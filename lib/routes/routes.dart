part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const MAINNAVBAR = Paths.MAINNAVBAR;
  static const SPLASH = Paths.SPLASH;
  static const LOGIN = Paths.LOGIN;
  static const REGISTRATION = Paths.REGISTRATION;
  static const MAPPAGE = Paths.MAPPAGE;
  static const LOGINPHARMA = Paths.LOGINPHARMA;
  static const REGISTRATIONPHARAMA = Paths.REGISTRATIONPHARAMA;
  static const PHARMANAVBAR = Paths.PHARMANAVBAR;
}

abstract class Paths {
  Paths._();
  static const MAINNAVBAR = '/main-navbar';
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const REGISTRATION = '/registration';
  static const MAPPAGE = '/map-page';
  static const LOGINPHARMA = '/login-pharma';
  static const REGISTRATIONPHARAMA = '/registration-pharma';
  static const PHARMANAVBAR = '/nav-pharama';

 
}
