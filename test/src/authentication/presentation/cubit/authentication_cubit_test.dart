import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testingapp/src/authentication/domain/usecases/create_user.dart';
import 'package:testingapp/src/authentication/domain/usecases/get_users.dart';
import 'package:testingapp/src/authentication/presentation/cubit/authentication_cubit.dart';

class MockCreateUser extends Mock implements CreateUser {}

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  late CreateUser createUser;
  late GetUsers getUsers;
  late AuthenticationCubit cubit;

  // why?
  const tCreateUserParams = CreateUserParams.empty();

  setUp(() {
    createUser = MockCreateUser();
    getUsers = MockGetUsers();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams); // why?
  });

  tearDown(() => cubit.close());

  test('Initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'Should emit [CreatingUser, UserCreated] when successful',
      build: () {

        // Here we use the MockCreateUser to see if it returns a Right or Left
        // That data passes to AuthenticationCubit.
        // And cubit responds according to it.
        when(
          () => createUser(any()),
        ).thenAnswer((_) async => const Right(null));
        return cubit;
      },

      act:
          (cubit) => cubit.createUser(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
      expect: () => const [CreatingUser(), UserCreated()],
    );
  });
}
