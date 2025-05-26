# Explanation of Cubit testing

First we mock `CreateUser()` and `GetUsers()`

### Group: `createUser`
#### blocTest: `Should emit [CreatingUser, UserCreated] when successful`
In the testing Arrangement, we call the `build:` method. Then we use `when` to use the mock version of CreateUser.<br>
```dart
group('createUser', () {
  blocTest<AuthenticationCubit, AuthenticationState>(
    'should return [CreatingUser, UserCreated] when successful', 
    build: () {
      when(() => createUser(any())).thenAnswer((_) async => Right(null));
      return cubit;
    },

    act: () {}
    expect: () {}
  );
});
```
In the when method, we use the MockCreateUser to see if it returns a Right or Left. 
That data passes to AuthenticationCubit. And cubit responds, according to it.

In the `act:` we record what state actually the cubit is emitting.
```dart
    act: (cubit) => cubit.createUser(
      createdAt: 'createdAt',
      name: 'name',
      avatar: 'avatar',
    )
```
It doesn't matter what value we are giving to the `createUser()` as long as it returns the states.

Finally, we expect the states in a list.
```dart
    expect: () => const [CreatingUser(), UserCreated()]
```
