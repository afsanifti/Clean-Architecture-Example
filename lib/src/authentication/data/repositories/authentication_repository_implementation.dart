import 'package:dartz/dartz.dart';
import 'package:testingapp/core/errors/exceptions.dart';
import 'package:testingapp/core/errors/failure.dart';
import 'package:testingapp/core/utils/typedefs.dart';
import 'package:testingapp/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:testingapp/src/authentication/domain/entities/user.dart';
import 'package:testingapp/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // Test Driven Development
    // call the remote data source
    // make sure it returns proper data if no exception
    // Chek if method returns proper data
    // // check if when the remoteDataSource throws an exception, we return a
    // failure and if it doesn't throw and exception, we return the actual
    // expected data.
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
