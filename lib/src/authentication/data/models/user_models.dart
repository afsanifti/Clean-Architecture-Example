import 'dart:convert';

import 'package:testingapp/core/utils/typedefs.dart';
import 'package:testingapp/src/authentication/domain/entities/user.dart';

class UserModels extends User {
  const UserModels({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  // takes a jsonString
  // converts it into map and then creates UserModels object with it
  factory UserModels.fromJson(String source) =>
      UserModels.fromMap(jsonDecode(source) as DataMap);

  // DataMap = Map<String, dynamic>
  // this creates UserModels objects from Map data
  UserModels.fromMap(DataMap map)
    : this(
        id: map['id'] as String,
        createdAt: map['createdAt'] as String,
        name: map['name'] as String,
        avatar: map['avatar'] as String,
      );

  // CopyWith:
  // To update our existing User object as the fields are final
  // ```const user = UserModels.empty();
  //    final newUser = user.copyWith(name: 'Alex'); ```

  UserModels copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) => UserModels(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    name: name ?? this.name,
    avatar: avatar ?? this.avatar,
  );

  DataMap toMap() => {
    'id': id,
    'createdAt': createdAt,
    'name': name,
    'avatar': avatar,
  };

  String toJson() => jsonEncode(toMap());

  const UserModels.empty()
      : this(
    id: '1',
    createdAt: '_empty.createdAt',
    name: '_empty.name',
    avatar: '_empty.avatar',
  );
}
