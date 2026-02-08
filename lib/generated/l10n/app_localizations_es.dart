// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Planificador de Viajes';

  @override
  String get auth_accountCreated => '¡Cuenta creada exitosamente!';

  @override
  String get auth_email => 'Correo Electrónico';

  @override
  String get auth_password => 'Contraseña';

  @override
  String get auth_confirmPassword => 'Confirmar Contraseña';

  @override
  String get home_welcome => 'Bienvenido';

  @override
  String get home_upcomingTrips => 'Próximos Viajes';

  @override
  String get home_recentlyViewed => 'Vistos Recientemente';

  @override
  String get errors_invalidEmail =>
      'Por favor ingresa un correo electrónico válido';

  @override
  String get errors_shortPassword =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get errors_passwordsDontMatch => 'Las contraseñas no coinciden';

  @override
  String get errors_requiredField => 'Este campo es requerido';

  @override
  String get errors_genericError =>
      'Ocurrió un error. Por favor inténtalo de nuevo.';

  @override
  String get signInSubtitle => 'Inicia sesión para continuar';

  @override
  String get welcomeBack => 'Bienvenido de Nuevo';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get or => 'O';

  @override
  String get alreadyHaveAccount => '¿Ya tienes cuenta? Iniciar Sesión';

  @override
  String get fullName => 'Nombre Completo';

  @override
  String get enterFullName => 'Ingresa tu nombre completo';

  @override
  String get enterEmail => 'Ingresa tu correo electrónico';

  @override
  String get enterPassword => 'Ingresa tu contraseña';

  @override
  String get enterConfirmPassword => 'Confirma tu contraseña';

  @override
  String get createAccountButton => 'Crear Cuenta';

  @override
  String get signInButton => 'Iniciar Sesión';

  @override
  String get fillInDetails => 'Completa tus datos para comenzar';

  @override
  String get journeyStartsHere => 'Tu viaje comienza aquí';

  @override
  String get signOut => 'Cerrar Sesión';

  @override
  String get settings => 'Configuración';

  @override
  String get appSettings => 'Ajustes de la aplicación';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get contactUs => 'Contáctenos';

  @override
  String get cancel => 'Cancelar';

  @override
  String get selectDate => 'Seleccionar una fecha';

  @override
  String get explore => 'Explorar';

  @override
  String get favorites => 'Favoritos';

  @override
  String get yourTrips => 'Tus Viajes';

  @override
  String get errorLoadingTrips => 'Error al cargar los viajes';

  @override
  String get noRecentTrips => 'Sin viajes recientes';

  @override
  String get startPlanning => 'Empieza a planear tu próxima aventura';

  @override
  String get addTrip => 'Agregar Viaje';

  @override
  String get totalTrips => 'Viajes Totales';

  @override
  String get totalBudget => 'Presupuesto Total';

  @override
  String get planned => 'Planeado';

  @override
  String get ongoing => 'En Curso';

  @override
  String get completed => 'Completado';

  @override
  String get tripDetails => 'Detalles del Viaje';

  @override
  String get close => 'Cerrar';

  @override
  String get description => 'Descripción';

  @override
  String get enterTripDescription => 'Ingrese la descripción del viaje';

  @override
  String get destination => 'Destino';

  @override
  String get enterDestination => 'Ingrese el destino';

  @override
  String get startDate => 'Fecha de Inicio';

  @override
  String get endDate => 'Fecha de Finalización';

  @override
  String get budget => 'Presupuesto';

  @override
  String get status => 'Estado';

  @override
  String get addNewTrip => 'Agregar Nuevo Viaje';

  @override
  String get editTrip => 'Editar Viaje';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get retry => 'Reintentar';

  @override
  String get tripTitle => 'Título del Viaje';

  @override
  String get updateTrip => 'Actualizar Viaje';

  @override
  String get enterTripTitle => 'Por favor ingrese un título de viaje';

  @override
  String get pleaseEnterValidNumber => 'Por favor ingrese un número válido';

  @override
  String get toast_welcomeBack => '¡Bienvenido de nuevo!';

  @override
  String get toast_invalidCredentials => 'Correo o contraseña inválidos';

  @override
  String get toast_tripCreated => '¡Viaje creado exitosamente!';

  @override
  String toast_tripError(String error) {
    return 'Error: $error';
  }

  @override
  String get toast_endDateAfterStart =>
      'La fecha de fin debe ser después de la fecha de inicio';

  @override
  String get toast_selectBothDates =>
      'Por favor selecciona fecha de inicio y fin';

  @override
  String get nav_home => 'Inicio';

  @override
  String get nav_explore => 'Explorar';

  @override
  String get nav_trips => 'Viajes';

  @override
  String get nav_saved => 'Guardados';

  @override
  String get quickActions => 'Acciones Rápidas';

  @override
  String get viewYourTrips => 'Ver tus viajes';

  @override
  String get recentPlaces => 'Lugares recientes';

  @override
  String get savedPlaces => 'Lugares guardados';

  @override
  String get recentActivity => 'Actividad Reciente';

  @override
  String get profile => 'Perfil';

  @override
  String comingSoon(String feature) {
    return '$feature - Próximamente';
  }

  @override
  String get tripStatusPlanned => 'Planeado';

  @override
  String get tripStatusOngoing => 'En curso';

  @override
  String get tripStatusCompleted => 'Completado';

  @override
  String get tripStatusCancelled => 'Cancelado';

  @override
  String get signInWithGoogle => 'Continuar con Google';

  @override
  String get tab_profile => 'Perfil';

  @override
  String get tab_preferences => 'Preferencias';

  @override
  String get tab_account => 'Cuenta';

  @override
  String get manageYourProfile => 'Gestiona tu perfil y preferencias';

  @override
  String get theme => 'Tema';

  @override
  String get chooseTheme => 'Elige tu tema preferido';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get manageNotifications =>
      'Gestiona tus preferencias de notificaciones';

  @override
  String get privacy => 'Privacidad';

  @override
  String get managePrivacy => 'Gestiona tu privacidad y configuración de datos';

  @override
  String get language => 'Idioma';

  @override
  String get signOutConfirmation =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get deleteAccount => 'Eliminar Cuenta';

  @override
  String get deleteAccountWarning => 'Esta acción no se puede deshacer';

  @override
  String get failedToSignOut => 'Error al cerrar sesión';

  @override
  String get deleteAccountConfirmation =>
      '¿Estás seguro de que quieres eliminar tu cuenta? Todos tus datos se eliminarán permanentemente.';

  @override
  String get failedToDeleteAccount => 'Error al eliminar la cuenta';

  @override
  String get deleteTrip => 'Eliminar Viaje';

  @override
  String deleteTripConfirmation(String tripTitle) {
    return '¿Estás seguro de que quieres eliminar \"$tripTitle\"?';
  }

  @override
  String get noTrips => 'No hay viajes aún';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get goHome => 'Ir al Inicio';

  @override
  String get pageNotFound => 'Página no encontrada';

  @override
  String get thePageYoureLookingForDoesntExist =>
      'La página que buscas no existe.';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get networkError => 'Error de Red';

  @override
  String get pleaseCheckYourInternetConnection =>
      'Por favor verifica tu conexión a internet e intenta de nuevo.';

  @override
  String get serverError => 'Error del Servidor';

  @override
  String get ourServersAreExperiencingIssues =>
      'Nuestros servidores están experimentando problemas. Por favor intenta más tarde.';

  @override
  String get unknownErrorMessage => 'Ocurrió un error desconocido';

  @override
  String get timeoutErrorMessage => 'La solicitud agotó el tiempo';

  @override
  String get successMessage => 'Operación completada exitosamente';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get email => 'Email';

  @override
  String get name => 'Name';

  @override
  String get enterName => 'Enter your name';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get save => 'Save';
}
