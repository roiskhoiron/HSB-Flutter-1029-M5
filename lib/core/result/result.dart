abstract class Result<T> {
  const Result();

  bool get isSuccess;
  bool get isFailure;
  T? get value;
  DomainError? get error;

  factory Result.success(T value) = Success<T>;
  factory Result.failure(DomainError error) = Failure<T>;
}

class Success<T> extends Result<T> {
  final T _value;

  const Success(this._value);

  @override
  bool get isSuccess => true;
  @override
  bool get isFailure => false;
  @override
  T get value => _value;
  @override
  DomainError? get error => null;
}

class Failure<T> extends Result<T> {
  final DomainError _error;

  const Failure(this._error);

  @override
  bool get isSuccess => false;
  @override
  bool get isFailure => true;
  @override
  T? get value => null;
  @override
  DomainError get error => _error;
}

abstract class DomainError {
  final String message;
  final String code;

  const DomainError(this.message, this.code);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DomainError && code == other.code;

  @override
  int get hashCode => code.hashCode;
}

class ValidationError extends DomainError {
  const ValidationError(super.message, super.code);
}

class AuthenticationError extends DomainError {
  const AuthenticationError(super.message, super.code);
}

class NotFoundError extends DomainError {
  const NotFoundError(super.message, super.code);
}

class ConflictError extends DomainError {
  const ConflictError(super.message, super.code);
}

class DataError extends DomainError {
  const DataError(super.message, super.code);
}

class NetworkError extends DomainError {
  const NetworkError(super.message, super.code);
}

class ServerError extends DomainError {
  const ServerError(super.message, super.code);
}
