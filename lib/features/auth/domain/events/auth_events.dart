abstract class AuthEvent {
  final DateTime timestamp;
  AuthEvent() : timestamp = DateTime.now();
}

class UserSignedIn extends AuthEvent {
  final String userId;
  final String email;

  UserSignedIn(this.userId, this.email);
}

class UserSignedUp extends AuthEvent {
  final String userId;
  final String email;
  final String name;

  UserSignedUp(this.userId, this.email, this.name);
}

class UserSignedOut extends AuthEvent {
  final String userId;

  UserSignedOut(this.userId);
}
