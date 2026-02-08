import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late DateTime createdAt;

  @HiveField(4)
  late DateTime updatedAt;

  @HiveField(5)
  late String password;

  UserModel();

  factory UserModel.fromDomain(User user, {String? password}) {
    return UserModel()
      ..id = user.id
      ..name = user.name
      ..email = user.email
      ..createdAt = user.createdAt
      ..updatedAt = user.updatedAt
      ..password = password ?? '';
  }

  User toDomain() {
    return User(
      id: id,
      name: name,
      email: email,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
