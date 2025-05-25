import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testingapp/src/authentication/domain/entities/user.dart';
import 'package:testingapp/src/authentication/domain/usecases/create_user.dart';
import 'package:testingapp/src/authentication/domain/usecases/get_users.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUser,
  }) : _createUser = createUser,
       _getUsers = getUser,
       super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        createdAt: event.createdAt,
        name: event.name,
        avatar: event.avatar,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> _getUserHandler(
    GetUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const GettingUsers());

    final result = await _getUsers();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      // the GetUser call returns a List of User
       // which is passed to the UsersLoaded
      (user) => emit(UsersLoaded(user)),
    );
  }
}
