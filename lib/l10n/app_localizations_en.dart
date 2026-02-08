import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Travel Planner';

  @override
  String get auth_signIn => 'Sign In';

  @override
  String get auth_signUp => 'Sign Up';

  @override
  String get auth_email => 'Email';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_confirmPassword => 'Confirm Password';

  @override
  String get auth_forgotPassword => 'Forgot Password?';

  @override
  String get auth_noAccount => 'Don\'t have an account? ';

  @override
  String get auth_haveAccount => 'Already have an account? ';

  @override
  String get auth_signInErrorTitle => 'Sign In Failed';

  @override
  String get auth_signUpErrorTitle => 'Sign Up Failed';

  @override
  String get home_welcome => 'Welcome';

  @override
  String get home_upcomingTrips => 'Upcoming Trips';

  @override
  String get home_recentlyViewed => 'Recently Viewed';

  @override
  String get errors_invalidEmail => 'Please enter a valid email address';

  @override
  String get errors_shortPassword => 'Password must be at least 6 characters';

  @override
  String get errors_passwordsDontMatch => 'Passwords don\'t match';

  @override
  String get errors_requiredField => 'This field is required';

  @override
  String get errors_genericError => 'An error occurred. Please try again.';
}
