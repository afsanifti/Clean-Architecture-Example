import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:testingapp/core/utils/constants.dart';
import 'package:testingapp/src/authentication/data/datasource/authentication_remote_data_source.dart';

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
            Uri.parse('$kBaseUrl$kCreateUserEndpoint'),
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

    test(
      'Should throw an [APIException] '
      'when the status code is note 200 or 201',
      () async {},
    );
  });
}
