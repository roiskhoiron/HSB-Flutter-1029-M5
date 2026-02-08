import 'package:get_it/get_it.dart';
import 'package:travel_planner/core/services/hive_service.dart';
import 'package:travel_planner/features/trips/data/repositories/trip_repository_impl.dart';
import 'package:travel_planner/features/trips/domain/repositories/trip_repository.dart';
import 'package:travel_planner/features/trips/domain/usecases/trip_usecases.dart';
import 'package:travel_planner/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:travel_planner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travel_planner/features/auth/domain/repositories/auth_repository.dart';
import 'package:travel_planner/features/auth/domain/usecases/authentication_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await HiveService.initialize();

  serviceLocator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      HiveService.getAuthBox(),
      HiveService.getUsersBox(),
    ),
  );
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AuthenticationUseCase>(
    () => AuthenticationUseCase(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<TripRepository>(
    () => TripRepositoryImpl(tripsBox: HiveService.getTripsBox()),
  );
  serviceLocator.registerLazySingleton<TripUseCases>(
    () => TripUseCases(serviceLocator()),
  );
}

AuthenticationUseCase getAuthenticationUseCase() => serviceLocator();
TripRepository getTripRepository() => serviceLocator();
