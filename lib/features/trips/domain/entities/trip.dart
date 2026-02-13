import 'package:travel_planner/features/trips/domain/value_objects/destination.dart';
import 'package:travel_planner/features/trips/domain/value_objects/travel_date.dart';
import 'package:travel_planner/features/trips/domain/value_objects/money.dart';

enum TripStatus { planned, upcoming, completed }

// 💎 Entity `Trip` ini sangat kaya (Rich Domain Model). Adanya getter seperti 
// `isUpcoming` dan `durationInDays` memindahkan logic bisnis ke tempat yang tepat! 💎📊
class Trip {
  final String id;
  final String title;
  final String description;
  final Destination destination;
  final TravelDate startDate;
  final TravelDate endDate;
  final Money budget;
  final TripStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  const Trip({
    required this.id,
    required this.title,
    required this.description,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.budget,
    this.status = TripStatus.planned,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  bool get isUpcoming {
    final now = DateTime.now();
    return startDate.value.isAfter(now) && status == TripStatus.planned;
  }

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(startDate.value) && now.isBefore(endDate.value);
  }

  bool get isCompleted => status == TripStatus.completed;

  int get durationInDays {
    return endDate.value.difference(startDate.value).inDays;
  }

  bool get isBudgetFriendly => budget.cents < 100000; // $1000.00 in cents

  Trip copyWith({
    String? id,
    String? title,
    String? description,
    Destination? destination,
    TravelDate? startDate,
    TravelDate? endDate,
    Money? budget,
    TripStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return Trip(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      budget: budget ?? this.budget,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Trip && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Trip(id: $id, title: $title, destination: $destination, status: $status)';

  /// Domain-level validation for trip dates.
  /// Returns null if valid, or a localization key for the error.
  static String? validateDates(DateTime? start, DateTime? end) {
    if (start == null || end == null) return 'toast_selectBothDates';
    if (end.isBefore(start)) return 'toast_endDateAfterStart';
    return null;
  }
}
