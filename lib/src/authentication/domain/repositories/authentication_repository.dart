import 'package:testingapp/core/utils/typedefs.dart';

import '../entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  // dartz 'Either'
  // Either will return Failure or void.
  // We don't have to specify with Exceptions.
  // It will automatically match the error message and status code
  // and give the related Exception as the other exceptions extends Failure

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
