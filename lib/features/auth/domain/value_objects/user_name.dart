import 'package:travel_planner/core/result/result.dart';

class UserName {
  final String value;

  UserName._(this.value);

  static Result<UserName> create(String name) {
    if (name.trim().isEmpty) {
      return Result.failure(
        const ValidationError('Name is required', 'NAME_REQUIRED'),
      );
    }

    final trimmedName = name.trim();

    if (trimmedName.length < 2) {
      return Result.failure(
        const ValidationError(
          'Name must be at least 2 characters',
          'NAME_TOO_SHORT',
        ),
      );
    }

    if (trimmedName.length > 50) {
      return Result.failure(
        const ValidationError('Name is too long', 'NAME_TOO_LONG'),
      );
    }

    return Result.success(UserName._(trimmedName));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserName && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
