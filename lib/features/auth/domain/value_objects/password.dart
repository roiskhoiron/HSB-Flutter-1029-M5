import 'package:travel_planner/core/result/result.dart';

class Password {
  final String value;

  Password._(this.value);

  static Result<Password> create(String password) {
    if (password.isEmpty) {
      return Result.failure(
        const ValidationError('Password is required', 'PASSWORD_REQUIRED'),
      );
    }

    if (password.length < 6) {
      return Result.failure(
        const ValidationError(
          'Password must be at least 6 characters',
          'PASSWORD_TOO_SHORT',
        ),
      );
    }

    return Result.success(Password._(password));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Password && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
