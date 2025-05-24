import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:testingapp/core/errors/exceptions.dart';
import 'package:testingapp/core/utils/constants.dart';
import 'package:testingapp/src/authentication/data/datasource/authentication_remote_data_source.dart';
import 'package:testingapp/src/authentication/data/models/user_models.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSrcImpl remoteDataSrcImpl;

  setUp(() {
    client = MockClient();
    remoteDataSrcImpl = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test(
      'Should complete successfully when the status code is 200 or 201',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201),
        );

        final methodCall = remoteDataSrcImpl.createUser;

        expect(
          methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          completes,
        );
        verify(
          () => client.post(
            Uri.http(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);
        verifyNoMoreInteractions(client);
      },
    );

    test('Should throw an [APIException] '
        'when the status code is not 200 or 201', () async {
      when(
        () => client.post(any(), body: any(named: 'body')),
      ).thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSrcImpl.createUser;

      expect(
        () =>
            methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
        throwsA(
          APIException(message: 'Invalid email address', statusCode: 400),
        ),
      );
      verify(
        () => client.post(
          Uri.http(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar',
          }),
        ),
      ).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    final tUsers = [UserModels.empty()];
    test('should complete successfully when'
        'status code is 200 or 201', () async {
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );

      final result = await remoteDataSrcImpl.getUsers();

      expect(result, equals(tUsers));
      verify(() => client.get(Uri.http(kBaseUrl, kGetUsersEndpoint))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('Should throw [APIException]'
        'when status code is not 200 or 201', () async {
      when(
        () => client.get(any()),
      ).thenAnswer((_) async => http.Response('Server down', 500));

      final methodCall = remoteDataSrcImpl.getUsers;

      expect(
        () => methodCall(),
        throwsA(const APIException(message: 'Server down', statusCode: 500)),
      );
      verify(() => client.get(Uri.http(kBaseUrl, kGetUsersEndpoint))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
