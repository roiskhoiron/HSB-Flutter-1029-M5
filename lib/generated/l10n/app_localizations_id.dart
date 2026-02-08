// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Perencana Perjalanan';

  @override
  String get auth_accountCreated => 'Akun berhasil dibuat!';

  @override
  String get auth_email => 'Email';

  @override
  String get auth_password => 'Kata Sandi';

  @override
  String get auth_confirmPassword => 'Konfirmasi Kata Sandi';

  @override
  String get home_welcome => 'Selamat Datang';

  @override
  String get home_upcomingTrips => 'Perjalanan Mendatang';

  @override
  String get home_recentlyViewed => 'Dilihat Baru-baru Ini';

  @override
  String get errors_invalidEmail => 'Silakan masukkan email yang valid';

  @override
  String get errors_shortPassword => 'Kata sandi harus minimal 6 karakter';

  @override
  String get errors_passwordsDontMatch => 'Kata sandi tidak cocok';

  @override
  String get errors_requiredField => 'Field ini diperlukan';

  @override
  String get errors_genericError => 'Terjadi kesalahan. Silakan coba lagi.';

  @override
  String get signInSubtitle => 'Masuk untuk melanjutkan';

  @override
  String get welcomeBack => 'Selamat Datang Kembali';

  @override
  String get createAccount => 'Buat Akun';

  @override
  String get or => 'ATAU';

  @override
  String get alreadyHaveAccount => 'Sudah punya akun? Masuk';

  @override
  String get fullName => 'Nama Lengkap';

  @override
  String get enterFullName => 'Masukkan nama lengkap Anda';

  @override
  String get enterEmail => 'Masukkan email Anda';

  @override
  String get enterPassword => 'Masukkan kata sandi Anda';

  @override
  String get enterConfirmPassword => 'Konfirmasi kata sandi Anda';

  @override
  String get createAccountButton => 'Buat Akun';

  @override
  String get signInButton => 'Masuk';

  @override
  String get fillInDetails => 'Isi detail Anda untuk memulai';

  @override
  String get journeyStartsHere => 'Perjalanan Anda dimulai di sini';

  @override
  String get signOut => 'Keluar';

  @override
  String get settings => 'Pengaturan';

  @override
  String get appSettings => 'Pengaturan Aplikasi';

  @override
  String get termsOfService => 'Ketentuan Layanan';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get contactUs => 'Hubungi Kami';

  @override
  String get cancel => 'Batal';

  @override
  String get selectDate => 'Pilih tanggal';

  @override
  String get explore => 'Jelajahi';

  @override
  String get favorites => 'Favorit';

  @override
  String get yourTrips => 'Perjalanan Anda';

  @override
  String get errorLoadingTrips => 'Gagal memuat perjalanan';

  @override
  String get noRecentTrips => 'Tidak ada perjalanan terbaru';

  @override
  String get startPlanning => 'Mulai rencanakan petualangan berikutnya';

  @override
  String get addTrip => 'Tambah Perjalanan';

  @override
  String get totalTrips => 'Total Perjalanan';

  @override
  String get totalBudget => 'Total Anggaran';

  @override
  String get planned => 'Direncanakan';

  @override
  String get ongoing => 'Sedang Berlangsung';

  @override
  String get completed => 'Selesai';

  @override
  String get tripDetails => 'Detail Perjalanan';

  @override
  String get close => 'Tutup';

  @override
  String get description => 'Deskripsi';

  @override
  String get enterTripDescription => 'Masukkan deskripsi perjalanan';

  @override
  String get destination => 'Tujuan';

  @override
  String get enterDestination => 'Masukkan tujuan';

  @override
  String get startDate => 'Tanggal Mulai';

  @override
  String get endDate => 'Tanggal Berakhir';

  @override
  String get budget => 'Anggaran';

  @override
  String get status => 'Status';

  @override
  String get addNewTrip => 'Tambah Perjalanan Baru';

  @override
  String get editTrip => 'Edit Perjalanan';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Hapus';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get tripTitle => 'Judul Perjalanan';

  @override
  String get updateTrip => 'Perbarui Perjalanan';

  @override
  String get enterTripTitle => 'Silakan masukkan judul perjalanan';

  @override
  String get pleaseEnterValidNumber => 'Silakan masukkan nomor yang valid';

  @override
  String get toast_welcomeBack => 'Selamat datang kembali!';

  @override
  String get toast_invalidCredentials => 'Email atau kata sandi tidak valid';

  @override
  String get toast_tripCreated => 'Perjalanan berhasil dibuat!';

  @override
  String toast_tripError(String error) {
    return 'Kesalahan: $error';
  }

  @override
  String get toast_endDateAfterStart =>
      'Tanggal akhir harus setelah tanggal mulai';

  @override
  String get toast_selectBothDates => 'Silakan pilih tanggal mulai dan akhir';

  @override
  String get nav_home => 'Beranda';

  @override
  String get nav_explore => 'Jelajahi';

  @override
  String get nav_trips => 'Perjalanan';

  @override
  String get nav_saved => 'Tersimpan';

  @override
  String get quickActions => 'Aksi Cepat';

  @override
  String get viewYourTrips => 'Lihat perjalanan Anda';

  @override
  String get recentPlaces => 'Tempat baru-baru ini';

  @override
  String get savedPlaces => 'Tempat tersimpan';

  @override
  String get recentActivity => 'Aktivitas Terbaru';

  @override
  String get profile => 'Profil';

  @override
  String comingSoon(String feature) {
    return '$feature - Segera Hadir';
  }

  @override
  String get tripStatusPlanned => 'Direncanakan';

  @override
  String get tripStatusOngoing => 'Sedang Berlangsung';

  @override
  String get tripStatusCompleted => 'Selesai';

  @override
  String get tripStatusCancelled => 'Dibatalkan';

  @override
  String get signInWithGoogle => 'Lanjutkan dengan Google';

  @override
  String get tab_profile => 'Profil';

  @override
  String get tab_preferences => 'Preferensi';

  @override
  String get tab_account => 'Akun';

  @override
  String get manageYourProfile => 'Kelola profil dan preferensi Anda';

  @override
  String get theme => 'Tema';

  @override
  String get chooseTheme => 'Pilih tema pilihan Anda';

  @override
  String get notifications => 'Notifikasi';

  @override
  String get manageNotifications => 'Kelola preferensi notifikasi Anda';

  @override
  String get privacy => 'Privasi';

  @override
  String get managePrivacy => 'Kelola privasi dan pengaturan data Anda';

  @override
  String get language => 'Bahasa';

  @override
  String get signOutConfirmation => 'Apakah Anda yakin ingin keluar?';

  @override
  String get deleteAccount => 'Hapus Akun';

  @override
  String get deleteAccountWarning => 'Tindakan ini tidak dapat dibatalkan';

  @override
  String get failedToSignOut => 'Gagal keluar';

  @override
  String get deleteAccountConfirmation =>
      'Apakah Anda yakin ingin menghapus akun Anda? Semua data Anda akan dihapus secara permanen.';

  @override
  String get failedToDeleteAccount => 'Gagal menghapus akun';

  @override
  String get deleteTrip => 'Hapus Perjalanan';

  @override
  String deleteTripConfirmation(String tripTitle) {
    return 'Apakah Anda yakin ingin menghapus \"$tripTitle\"?';
  }

  @override
  String get noTrips => 'Belum ada perjalanan';

  @override
  String get somethingWentWrong => 'Terjadi kesalahan';

  @override
  String get goHome => 'Pergi ke Beranda';

  @override
  String get pageNotFound => 'Halaman tidak ditemukan';

  @override
  String get thePageYoureLookingForDoesntExist =>
      'Halaman yang Anda cari tidak ada.';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get networkError => 'Kesalahan Jaringan';

  @override
  String get pleaseCheckYourInternetConnection =>
      'Silakan periksa koneksi internet Anda dan coba lagi.';

  @override
  String get serverError => 'Kesalahan Server';

  @override
  String get ourServersAreExperiencingIssues =>
      'Server kami mengalami masalah. Silakan coba lagi nanti.';

  @override
  String get unknownErrorMessage => 'Terjadi kesalahan yang tidak diketahui';

  @override
  String get timeoutErrorMessage => 'Permintaan habis waktu';

  @override
  String get successMessage => 'Operasi berhasil diselesaikan';

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
