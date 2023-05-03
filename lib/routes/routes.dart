part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const MAINNAVBAR = Paths.MAINNAVBAR;
  // static const HOME = Paths.HOME;
  // static const HISTORY = Paths.HISTORY;
  // static const CHAT = Paths.CHAT;
  // static const MEDICINE = Paths.MEDICINE;
  static const SPLASH = Paths.SPLASH;
  static const LOGIN = Paths.LOGIN;
  static const REGISTRATION = Paths.REGISTRATION;
  static const MAPPAGE = Paths.MAPPAGE;
}

abstract class Paths {
  Paths._();
  static const MAINNAVBAR = '/main-navbar';
  // static const HOME = '/home'; 
  // static const HISTORY = '/history';
  // static const CHAT = '/chat-page';
  // static const MEDICINE = '/medicine-page';
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const REGISTRATION = '/registration';
  static const MAPPAGE = '/map-page';

 
}
