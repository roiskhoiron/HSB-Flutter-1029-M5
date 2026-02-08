import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
import 'package:travel_planner/features/auth/domain/value_objects/email.dart';
import 'package:travel_planner/features/auth/domain/value_objects/password.dart';
import 'package:travel_planner/features/auth/domain/value_objects/user_name.dart';
import 'package:travel_planner/features/auth/domain/events/auth_events.dart';

class AuthenticationUseCase {
  final AuthRepository _repository;
  final List<void Function(AuthEvent)> _eventHandlers = [];

  AuthenticationUseCase(this._repository);

  void addEventHandler(void Function(AuthEvent) handler) {
    _eventHandlers.add(handler);
  }

  Future<Result<User?>> getCurrentUser() async {
    return _repository.getCurrentUser();
  }

  Future<Result<User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final nameResult = UserName.create(name);
    if (nameResult.isFailure) {
      return Result.failure(nameResult.error!);
    }

    final emailResult = Email.create(email);
    if (emailResult.isFailure) {
      return Result.failure(emailResult.error!);
    }

    final passwordResult = Password.create(password);
    if (passwordResult.isFailure) {
      return Result.failure(passwordResult.error!);
    }

    try {
      final signUpResult = await _repository.signUp(
        name: nameResult.value!.value,
        email: emailResult.value!.value,
        password: passwordResult.value!.value,
      );

      if (signUpResult.isFailure) {
        return signUpResult;
      }

      final user = signUpResult.value!;
      final event = UserSignedUp(user.id, user.email, user.name);
      for (final handler in _eventHandlers) {
        handler(event);
      }

      return Result.success(user);
    } catch (e) {
      return Result.failure(
        const AuthenticationError('Failed to register', 'REGISTER_FAILED'),
      );
    }
  }

  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    final emailResult = Email.create(email);
    if (emailResult.isFailure) {
      return Result.failure(emailResult.error!);
    }

    final passwordResult = Password.create(password);
    if (passwordResult.isFailure) {
      return Result.failure(passwordResult.error!);
    }

    final loginResult = await _repository.signIn(
      email: emailResult.value!.value,
      password: passwordResult.value!.value,
    );

    if (loginResult.isFailure) {
      return loginResult;
    }

    final user = loginResult.value!;
    final event = UserSignedIn(user.id, user.email);
    for (final handler in _eventHandlers) {
      handler(event);
    }

    return Result.success(user);
  }

  Future<Result<void>> logout() async {
    final userResult = await _repository.getCurrentUser();
    if (userResult.isFailure) {
      return userResult;
    }

    final signOutResult = await _repository.signOut();
    if (signOutResult.isFailure) {
      return signOutResult;
    }

    final event = UserSignedOut(userResult.value!.id);
    for (final handler in _eventHandlers) {
      handler(event);
    }

    return Result.success(null);
  }
}
