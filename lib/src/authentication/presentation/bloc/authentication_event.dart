part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  final String createdAt;
  final String name;
  final String avatar;

  @override
  // TODO: implement props
  List<Object?> get props => [createdAt, name, avatar];
}

class GetUserEvent extends AuthenticationEvent {
  const GetUserEvent();
}
