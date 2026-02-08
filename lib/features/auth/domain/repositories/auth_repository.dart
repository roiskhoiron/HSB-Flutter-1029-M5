import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/core/result/result.dart';

abstract class AuthRepository {
  Future<Result<User>> signUp({
    required String email,
    required String password,
    required String name,
  });
  Future<Result<User>> signIn({
    required String email,
    required String password,
  });
  Future<Result<User>> getCurrentUser();
  Future<Result<void>> signOut();
  Future<Result<User>> updateProfile({
    required String name,
    required String email,
  });
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  bool isLoggedIn();
}
