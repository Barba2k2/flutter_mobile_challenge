import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/google_sign_in_use_case.dart';
import '../../domain/use_cases/login_usecase.dart';
import '../../domain/use_cases/register_usecase.dart';
import '../../domain/use_cases/sign_out_use_case.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final SignOutUseCase _signOutUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required SignOutUseCase signOutUseCase,
    required GoogleSignInUseCase googleSignInUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _signOutUseCase = signOutUseCase,
       _googleSignInUseCase = googleSignInUseCase,
       super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<GoogleSignInRequested>(_onGoogleSignIn);
  }

  Future<void> _onLogin(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _loginUseCase.login(event.email, event.password);

    result.fold(
      (error) => emit(AuthError(error.toString())),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _registerUseCase.register(event.email, event.password);

    result.fold(
      (error) => emit(AuthError(error.toString())),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _signOutUseCase.signOut();

    result.fold(
      (error) => emit(AuthError(error.toString())),
      (_) => emit(Unauthenticated()),
    );
  }

  Future<void> _onGoogleSignIn(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _googleSignInUseCase.signIn();

    result.fold(
      (error) => emit(AuthError(error.toString())),
      (user) => emit(Authenticated(user)),
    );
  }
}
