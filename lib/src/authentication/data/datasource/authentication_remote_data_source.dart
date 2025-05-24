import 'dart:convert';

import 'package:testingapp/core/errors/exceptions.dart';
import 'package:testingapp/core/utils/typedefs.dart';
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

const kCreateUserEndpoint = '/test-api/user';
const kGetUsersEndpoint = '/test-api/user';

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
    try {
      final response = await _client.post(
        Uri.http(kBaseUrl, kCreateUserEndpoint),
        body: jsonEncode({
          'createdAt': createdAt,
          'name': name,
          'avatar': avatar,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModels>> getUsers() async {
    try {
      final response = await _client.get(Uri.http(kBaseUrl, kGetUsersEndpoint));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      return List<DataMap>.from(
        jsonDecode(response.body) as List,
      ).map((userData) => UserModels.fromMap(userData)).toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
