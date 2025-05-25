part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);

  final List<User> users;

  // Dart faces problem when checking if both lists are same.
  // so we create a new List by mapping each user's id.
  // we check if this list of user has the same ids as the next list of users
  @override
  List<Object?> get props => users.map((user) => user.id).toList();
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<String?> get props => [message];
}
