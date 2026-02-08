import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:travel_planner/features/trips/domain/entities/trip.dart';
import 'package:travel_planner/features/trips/domain/value_objects/destination.dart';
import 'package:travel_planner/features/trips/domain/value_objects/travel_date.dart';
import 'package:travel_planner/features/trips/domain/value_objects/money.dart';

part 'trip_model.g.dart';

@HiveType(typeId: 2)
class TripModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String destination;

  @HiveField(4)
  final DateTime startDate;

  @HiveField(5)
  final DateTime endDate;

  @HiveField(6)
  final double budget; // Store as double for Hive, convert to Money in domain

  @HiveField(7)
  final String status;

  @HiveField(8)
  final DateTime createdAt;

  @HiveField(9)
  final DateTime updatedAt;

  @HiveField(10)
  final String userId;

  TripModel({
    required this.id,
    required this.title,
    required this.description,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.budget,
    this.status = 'planned',
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory TripModel.fromDomain(Trip trip, String userId) {
    return TripModel(
      id: trip.id,
      title: trip.title,
      description: trip.description,
      destination: trip.destination.value,
      startDate: trip.startDate.value,
      endDate: trip.endDate.value,
      budget: trip.budget.amount,
      status: trip.status.name,
      createdAt: trip.createdAt,
      updatedAt: trip.updatedAt,
      userId: userId,
    );
  }

  Trip toDomain() {
    return Trip(
      id: id,
      title: title,
      description: description,
      destination: Destination.restore(destination),
      startDate: TravelDate.restore(startDate),
      endDate: TravelDate.restore(endDate),
      budget: Money.fromAmount(budget, 'USD'),
      status: TripStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => TripStatus.planned,
      ),
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'destination': destination,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'budget': budget,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'userId': userId,
  };

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      destination: json['destination'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      budget: json['budget'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
    );
  }

  TripModel copyWith({
    String? id,
    String? title,
    String? description,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    double? budget,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return TripModel(
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
}
