import 'package:travel_planner/core/result/result.dart';

class Destination {
  final String value;

  Destination._(this.value);

  static Result<Destination> create(String destination) {
    if (destination.trim().isEmpty) {
      return Result.failure(
        const ValidationError(
          'Destination is required',
          'DESTINATION_REQUIRED',
        ),
      );
    }

    final trimmedDestination = destination.trim();

    if (trimmedDestination.length < 2) {
      return Result.failure(
        const ValidationError(
          'Destination must be at least 2 characters',
          'DESTINATION_TOO_SHORT',
        ),
      );
    }

    if (trimmedDestination.length > 100) {
      return Result.failure(
        const ValidationError(
          'Destination is too long',
          'DESTINATION_TOO_LONG',
        ),
      );
    }

    return Result.success(Destination._(trimmedDestination));
  }

  static Destination restore(String value) {
    return Destination._(value);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Destination && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
