import 'package:testingapp/core/usecase/usecase.dart';
import 'package:testingapp/core/utils/typedefs.dart';
import 'package:testingapp/src/authentication/domain/repositories/authentication_repository.dart';

import '../entities/user.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
