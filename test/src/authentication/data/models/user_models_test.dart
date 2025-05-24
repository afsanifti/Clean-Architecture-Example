import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:testingapp/core/utils/typedefs.dart';
import 'package:testingapp/src/authentication/data/models/user_models.dart';
import 'package:testingapp/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModels.empty();

  test("should be subclass of [User] entity", () {
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group("fromMap()", () {
    test("Should return [UserModels] with the right User object data", () {
      // act
      final result = UserModels.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test("Should return [UserModels] with the right User object data", () {
      final result = UserModels.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("Should return [UserModels] with the right Map data", () {
      final result = tModel.toMap();
      expect(result, tMap);
    });
  });

  group("toJson", () {
    test("Should return [UserModels] with the right JSON data", () {
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
      });
      expect(result, tJson);
    });
  });

  group("copyWith", (){
    test("Should return [UserModel]", (){
      final result = tModel.copyWith(name: "Afsan");
      expect(result.name, 'Afsan');
    });
  });
}
