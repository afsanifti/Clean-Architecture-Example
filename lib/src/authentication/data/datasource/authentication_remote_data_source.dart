import 'dart:convert';

import 'package:testingapp/src/authentication/data/models/user_models.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/constants.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModels>> getUsers();
}

const kCreateUserEndpoint = '/user';
const kGetUsersEndpoint = '/user';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  const AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // 1. check to make sure that it returns the right data when the status
    // code is 200 or the proper response code
    // 2. check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
    // right msg when status code is a bad one
    final response = _client.post(
      Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
      body: jsonEncode({
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
      }),
    );
  }

  @override
  Future<List<UserModels>> getUsers() async {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
