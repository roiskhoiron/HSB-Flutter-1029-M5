class AppRoutes {
  AppRoutes._();

  static const String home = 'home';
  static const String explore = 'explore';
  static const String trips = 'trips';
  static const String saved = 'saved';
  static const String tripDetail = 'trip-detail';
  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String auth = 'auth';
  static const String signIn = 'sign-in';
  static const String signUp = 'sign-up';
  static const String terms = 'terms';
  static const String privacy = 'privacy';

  static const String homePath = '/home';
  static const String explorePath = '/explore';
  static const String tripsPath = '/trips';
  static const String savedPath = '/saved';
  static const String tripDetailPath = '/trips/:id';
  static const String profilePath = '/profile';
  static const String settingsPath = '/settings';
  static const String authPath = '/auth';
  static const String signInPath = '/auth/sign-in';
  static const String signUpPath = '/auth/sign-up';
  static const String termsPath = '/terms';
  static const String privacyPath = '/privacy';

  static String buildTripDetailPath(String id) => '/trips/$id';
}
