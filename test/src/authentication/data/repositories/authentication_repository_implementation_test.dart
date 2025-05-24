import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:testingapp/core/errors/exceptions.dart';
import 'package:testingapp/core/errors/failure.dart';
import 'package:testingapp/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:testingapp/src/authentication/data/models/user_models.dart';
import 'package:testingapp/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:testingapp/src/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRepositoryImplementation repoImpl;
  late AuthenticationRemoteDataSource remoteDataSource;

  final tException = const APIException(
    message: 'Unknown error occurred',
    statusCode: 500,
  );

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  group("createUser", () {
    final createdAt = 'whatever.createdAt';
    final name = 'whatever.name';
    final avatar = 'whatever.avatar';

    test('Should call [remotesDataSrc.createUser] and complete'
        'successfully when the call is successful', () async {
      // arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer(
        (_) => Future.value(),
      ); // Future.value() to return 'Future<void>

      // act
      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // assert
      expect(result, equals(const Right(null)));
      // check that remoteDataSrc's createUser gets called and with right data
      verify(
        () => remoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('Should return a [ServerFailure]'
        'when the call to remoteDataSrc is unsuccessful', () async {
      // arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(tException);

      // act
      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // assert
      expect(
        result,
        equals(
          Left(
            APIFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );

      verify(
        () => remoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUser', () {
    test(
      'Should call [remoteDataSrc.getUsers] and'
      'return [List<User>] when call to remote source is successful',
      () async {
        const users = [UserModels.empty()];

        when(() => remoteDataSource.getUsers()).thenAnswer((_) async => users);

        final result = await repoImpl.getUsers();

        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test('Should return a [ServerFailure]'
        'when the call to remoteDataSrc is unsuccessful', () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      final result = await repoImpl.getUsers();

      expect(result, equals(Left(APIFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
