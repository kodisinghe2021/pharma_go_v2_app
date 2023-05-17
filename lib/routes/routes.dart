part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  //--- splash paths
  static const SPLASH = Paths.SPLASH;

  //--- clients paths
  static const CLIENTMAINNAVBAR = Paths.CLIENTMAINNAVBAR;
  static const CLIENTLOGIN = Paths.CLIENTLOGIN;
  static const CLIENTREGISTRATION = Paths.CLIENTREGISTRATION;

  //-------------------------
  // static const MAPPAGE = Paths.MAPPAGE;
  // static const LOGINPHARMA = Paths.LOGINPHARMA;
  // static const REGISTRATIONPHARAMA = Paths.REGISTRATIONPHARAMA;
  // static const PHARMANAVBAR = Paths.PHARMANAVBAR;
  // static const ORDERDATAILS = Paths.ORDERDATAILS;
}

abstract class Paths {
  Paths._();
  //--- splash path
  static const SPLASH = '/splash';

  //--- client paths
  static const CLIENTREGISTRATION = '/client-registration';
  static const CLIENTLOGIN = '/client-login';
  static const CLIENTMAINNAVBAR = '/client-main-navbar';

  //------------------
  // static const MAPPAGE = '/map-page';
  // static const LOGINPHARMA = '/login-pharma';
  // static const REGISTRATIONPHARAMA = '/registration-pharma';
  // static const PHARMANAVBAR = '/nav-pharama';
  // static const ORDERDATAILS = '/orderdetails';
}
