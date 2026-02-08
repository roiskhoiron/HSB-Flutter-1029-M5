import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUser(User user, String password);
  Future<Map<String, dynamic>?> getUserByEmail(String email);
  Future<User?> getCurrentUser();
  Future<void> saveCurrentSession(User user);
  Future<void> clearCurrentSession();
  Future<void> updateUser(User user);
  Future<void> updateUserPassword(String email, String password);
  bool hasCurrentSession();
  bool isLoggedIn();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box _authBox;
  final Box<UserModel> _usersBox;

  AuthLocalDataSourceImpl(this._authBox, this._usersBox);

  @override
  Future<void> saveUser(User user, String password) async {
    try {
      final userModel = UserModel.fromDomain(user, password: password);
      await _usersBox.put(user.id, userModel);

      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).info('User saved with ID: ${user.id}');
    } catch (e) {
      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).severe('Failed to save user: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      final normalizedEmail = email.toLowerCase().trim();

      for (final userModel in _usersBox.values) {
        if (userModel.email.toLowerCase().trim() == normalizedEmail) {
          return {
            'user': userModel.toDomain().toMap(),
            'password': userModel.password,
            'createdAt': userModel.createdAt.toIso8601String(),
          };
        }
      }
      return null;
    } catch (e) {
      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).severe('Failed to get user by email: $e');
    }
    return null;
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userData = _authBox.get('user');
      if (userData == null) return null;

      final castedData = (userData as Map).cast<String, dynamic>();
      return User.fromMap(castedData);
    } catch (e) {
      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).severe('Failed to get current user: $e');
      return null;
    }
  }

  @override
  Future<void> saveCurrentSession(User user) async {
    try {
      _authBox.put('user', user.toMap());
      _authBox.put('isLoggedIn', true);
      _authBox.put('lastLogin', DateTime.now().toIso8601String());

      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).info('Session saved for user: ${user.id}');
    } catch (e) {
      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).severe('Failed to save session: $e');
    }
  }

  @override
  Future<void> clearCurrentSession() async {
    try {
      await _authBox.clear();
      AppLogger.getLogger('AuthLocalDataSource').info('Session cleared');
    } catch (e) {
      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).severe('Failed to clear current session: $e');
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      final userModel = _usersBox.get(user.id);

      if (userModel != null) {
        userModel.name = user.name;
        userModel.email = user.email;
        userModel.updatedAt = user.updatedAt;
        await userModel.save();

        final authUserData = _authBox.get('user');
        final currentUser = authUserData != null
            ? User.fromMap((authUserData as Map).cast<String, dynamic>())
            : null;
        if (currentUser?.id == user.id) {
          await saveCurrentSession(user);
        }

        AppLogger.getLogger(
          'AuthLocalDataSource',
        ).info('User updated: ${user.id}');
      }
    } catch (e) {
      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).severe('Failed to update user: $e');
    }
  }

  @override
  Future<void> updateUserPassword(String email, String password) async {
    try {
      final normalizedEmail = email.toLowerCase().trim();

      UserModel? targetUser;
      for (final userModel in _usersBox.values) {
        if (userModel.email.toLowerCase().trim() == normalizedEmail) {
          targetUser = userModel;
          break;
        }
      }

      if (targetUser != null) {
        targetUser.password = password;
        await targetUser.save();

        AppLogger.getLogger(
          'AuthLocalDataSource',
        ).info('Password updated for User ID: ${targetUser.id}');
      }
    } catch (e) {
      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).severe('Failed to update password: $e');
    }
  }

  @override
  bool hasCurrentSession() {
    try {
      final isLoggedIn =
          _authBox.get('isLoggedIn', defaultValue: false) as bool;
      return isLoggedIn;
    } catch (e) {
      AppLogger.getLogger(
        'AuthLocalDataSource',
      ).warning('Failed to check session: $e');
      return false;
    }
  }

  @override
  bool isLoggedIn() {
    return hasCurrentSession();
  }
}
