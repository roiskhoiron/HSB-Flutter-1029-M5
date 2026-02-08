import 'package:travel_planner/core/result/result.dart';

class Email {
  final String value;

  Email._(this.value);

  static Result<Email> create(String email) {
    if (email.trim().isEmpty) {
      return Result.failure(
        const ValidationError('Email is required', 'EMAIL_REQUIRED'),
      );
    }

    final trimmedEmail = email.trim();

    if (!trimmedEmail.contains('@') || !trimmedEmail.contains('.')) {
      return Result.failure(
        const ValidationError('Please enter a valid email', 'EMAIL_INVALID'),
      );
    }

    return Result.success(Email._(trimmedEmail));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Email && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
