import 'package:travel_planner/core/result/result.dart';

class TravelDate {
  final DateTime value;

  TravelDate._(this.value);

  static Result<TravelDate> create(DateTime date) {
    final now = DateTime.now();

    if (date.isBefore(now)) {
      return Result.failure(
        const ValidationError(
          'Travel date cannot be in the past',
          'DATE_IN_PAST',
        ),
      );
    }

    final twoYearsFromNow = DateTime(now.year + 2, now.month, now.day);
    if (date.isAfter(twoYearsFromNow)) {
      return Result.failure(
        const ValidationError(
          'Travel date cannot be more than 2 years in advance',
          'DATE_TOO_FAR',
        ),
      );
    }

    return Result.success(TravelDate._(date));
  }

  static TravelDate restore(DateTime date) {
    return TravelDate._(date);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TravelDate && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '${value.day}/${value.month}/${value.year}';
}
