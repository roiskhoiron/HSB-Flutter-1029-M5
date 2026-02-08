import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:uuid/uuid.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  final _uuid = const Uuid();

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<Result<User>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final normalizedEmail = email.toLowerCase().trim();
      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).info('Starting sign up for email: $normalizedEmail');

      final existingUser = await _localDataSource.getUserByEmail(
        normalizedEmail,
      );
      if (existingUser != null) {
        return Result.failure(
          const AuthenticationError(
            'User with this email already exists',
            'EMAIL_EXISTS',
          ),
        );
      }

      final user = User(
        id: _uuid.v7(),
        name: name,
        email: normalizedEmail,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _localDataSource.saveUser(user, password);
      await _localDataSource.saveCurrentSession(user);

      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).info('Sign up successful for user: ${user.id}');
      return Result.success(user);
    } catch (e) {
      AppLogger.getLogger('AuthRepositoryImpl').severe('Sign up failed: $e');
      return Result.failure(
        AuthenticationError('Failed to sign up', e.toString()),
      );
    }
  }

  @override
  Future<Result<User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final normalizedEmail = email.toLowerCase().trim();
      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).info('Starting sign in for email: $normalizedEmail');

      final userData = await _localDataSource.getUserByEmail(normalizedEmail);
      if (userData == null) {
        return Result.failure(
          const NotFoundError('User not found', 'USER_NOT_FOUND'),
        );
      }

      final storedPassword = userData['password'] as String;
      if (storedPassword != password) {
        return Result.failure(
          const AuthenticationError(
            'Invalid email or password',
            'INVALID_CREDENTIALS',
          ),
        );
      }

      final user = User.fromMap(userData['user'] as Map<String, dynamic>);

      await _localDataSource.saveCurrentSession(user);

      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).info('Sign in successful for user: ${user.id}');
      return Result.success(user);
    } catch (e) {
      AppLogger.getLogger('AuthRepositoryImpl').severe('Sign in failed: $e');
      return Result.failure(
        AuthenticationError('Failed to sign in', e.toString()),
      );
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final user = await _localDataSource.getCurrentUser();
      if (user == null) {
        return Result.failure(
          const NotFoundError('No user logged in', 'NO_USER_LOGGED_IN'),
        );
      }
      return Result.success(user);
    } catch (e) {
      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).severe('Get current user failed: $e');
      return Result.failure(
        AuthenticationError('Failed to get current user', e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> signOut() async {
    try {
      await _localDataSource.clearCurrentSession();
      return Result.success(null);
    } catch (e) {
      AppLogger.getLogger('AuthRepositoryImpl').severe('Sign out failed: $e');
      return Result.failure(
        AuthenticationError('Failed to sign out', e.toString()),
      );
    }
  }

  @override
  Future<Result<User>> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      final currentUser = await _localDataSource.getCurrentUser();
      if (currentUser == null) {
        return Result.failure(
          const AuthenticationError('No user logged in', 'NO_USER_LOGGED_IN'),
        );
      }

      final updatedUser = currentUser.copyWith(
        name: name,
        email: email,
        updatedAt: DateTime.now(),
      );

      await _localDataSource.updateUser(updatedUser);
      await _localDataSource.saveCurrentSession(updatedUser);

      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).info('Profile updated for user: ${updatedUser.id}');
      return Result.success(updatedUser);
    } catch (e) {
      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).severe('Update profile failed: $e');
      return Result.failure(
        AuthenticationError('Failed to update profile', e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final currentUser = await _localDataSource.getCurrentUser();
      if (currentUser == null) {
        return Result.failure(
          const AuthenticationError('No user logged in', 'NO_USER_LOGGED_IN'),
        );
      }

      final userData = await _localDataSource.getUserByEmail(currentUser.email);
      if (userData == null) {
        return Result.failure(
          const NotFoundError('User not found', 'USER_NOT_FOUND'),
        );
      }

      final storedPassword = userData['password'] as String;
      if (storedPassword != currentPassword) {
        return Result.failure(
          const AuthenticationError(
            'Current password is incorrect',
            'INVALID_CURRENT_PASSWORD',
          ),
        );
      }

      await _localDataSource.updateUserPassword(currentUser.email, newPassword);

      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).info('Password changed for user: ${currentUser.id}');
      return Result.success(null);
    } catch (e) {
      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).severe('Change password failed: $e');
      return Result.failure(
        AuthenticationError('Failed to change password', e.toString()),
      );
    }
  }

  @override
  bool isLoggedIn() {
    try {
      return _localDataSource.isLoggedIn();
    } catch (e) {
      AppLogger.getLogger(
        'AuthRepositoryImpl',
      ).severe('Error checking login status: $e');
      return false;
    }
  }
}
