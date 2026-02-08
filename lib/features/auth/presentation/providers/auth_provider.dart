import 'package:flutter/material.dart';
import 'package:travel_planner/features/auth/domain/entities/user.dart';
import 'package:travel_planner/features/auth/domain/usecases/authentication_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final AuthenticationUseCase _authenticationUseCase;
  User? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isInitialized = false;

  AuthProvider({required AuthenticationUseCase authenticationUseCase})
    : _authenticationUseCase = authenticationUseCase;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;
    await _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authenticationUseCase.getCurrentUser();
      if (result.isSuccess && result.value != null) {
        _currentUser = result.value;
      }
    } catch (e) {
      _error = 'Failed to load user';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authenticationUseCase.login(
        email: email,
        password: password,
      );
      if (result.isSuccess) {
        _currentUser = result.value;
      } else {
        _error = result.error?.message ?? 'Login failed';
      }
    } catch (e) {
      _error = 'Login failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authenticationUseCase.register(
        name: name,
        email: email,
        password: password,
      );
      if (result.isSuccess) {
        _currentUser = result.value;
      } else {
        _error = result.error?.message ?? 'Registration failed';
      }
    } catch (e) {
      _error = 'Registration failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _authenticationUseCase.logout();
      if (result.isSuccess) {
        _currentUser = null;
      } else {
        _error = result.error?.message ?? 'Logout failed';
      }
    } catch (e) {
      _error = 'Logout failed';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
