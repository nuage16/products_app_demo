import 'package:fpdart/fpdart.dart';
import 'errors/failure.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
