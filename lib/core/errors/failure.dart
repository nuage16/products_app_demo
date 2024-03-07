import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

/// General failures
class ServerFailure extends Failure {
 const ServerFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
