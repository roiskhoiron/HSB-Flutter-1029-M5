import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/core/security/input_sanitizer.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repository;
  SignUpUseCase(this._repository);

  Future<Result<User>> execute({
    required String email,
    required String password,
    required String name,
  }) async {
    final sanitizedEmail = InputSanitizer.sanitizeEmail(email);
    final sanitizedName = InputSanitizer.sanitizeName(name);
    final sanitizedPassword = InputSanitizer.sanitizePassword(password);

    if (sanitizedName.isEmpty) {
      return Result.failure(
        const ValidationError('Name cannot be empty', 'NAME_EMPTY'),
      );
    }

    return _repository.signUp(
      email: sanitizedEmail,
      password: sanitizedPassword,
      name: sanitizedName,
    );
  }
}
