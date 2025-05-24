import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testingapp/src/authentication/domain/entities/user.dart';
import 'package:testingapp/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:testingapp/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUser usecase;

  setUp(() async {
    repository = MockAuthRepo();
    usecase = GetUser(repository);
  });

  const tResponse = [User.empty()];

  test('Should call [Repository.getUser] and return [List<User>]', () async {
    when(
      // calling getUser from the abstract function
      () => repository.getUsers(),
    ).thenAnswer((_) async => const Right(tResponse));

    // remember GetUser() is a callable function
    // calling getUser from the callable function
    final result = await usecase();

    // comparing two results
    // Right() can be omitted
    expect(result, Right<dynamic, List<User>>(tResponse));
  });
}
