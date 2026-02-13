import 'package:dartz/dartz.dart';

typedef AsyncResultPosts<T extends Object> = Future<Either<Exception, T>>;
typedef AsyncResultAuth<T extends Object> = Future<Either<Exception, T>>;
