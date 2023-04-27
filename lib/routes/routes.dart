part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = Paths.HOME;
  static const SPLASH = Paths.SPLASH;
  static const LOGIN = Paths.LOGIN;
  static const REGISTRATION = Paths.REGISTRATION;
}

abstract class Paths {
  Paths._();
  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const REGISTRATION = '/registration';
}
