part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  //--- splash paths
  static const SPLASH = Paths.SPLASH;

  //--- clients paths
  static const CLIENTMAINNAVBAR = Paths.CLIENTMAINNAVBAR;
  static const CLIENTLOGIN = Paths.CLIENTLOGIN;
  static const CLIENTREGISTRATION = Paths.CLIENTREGISTRATION;

  //--- pharama side
  static const PHARMALOGIN = Paths.PHARMALOGIN;
  static const PHARMAREGISTRATION = Paths.PHARMAREGISTRATION;
  static const PHARMANAVBAR = Paths.PHARMANAVBAR;

  // static const MAPPAGE = Paths.MAPPAGE;
  // static const ORDERDATAILS = Paths.ORDERDATAILS;

  //pharmacy list
  static const PHARMACYLIST = Paths.PHARMACYLIST;

  static const ORDERSPAGE = Paths.ORDERSPAGE;

  static const CARTPAGE = Paths.CARTPAGE;

  static const PAYPAGE = Paths.PAYPAGE;

}

abstract class Paths {
  Paths._();
  //--- splash path
  static const SPLASH = '/splash';

  //--- client paths
  static const CLIENTREGISTRATION = '/client-registration';
  static const CLIENTLOGIN = '/client-login';
  static const CLIENTMAINNAVBAR = '/client-main-navbar';

  //--- pharama side
  static const PHARMAREGISTRATION = '/registration-pharma';
  static const PHARMALOGIN = '/login-pharma';
  static const PHARMANAVBAR = '/nav-pharama';
  // static const MAPPAGE = '/map-page';
  // static const ORDERDATAILS = '/orderdetails';

  //pharmacy list
  static const PHARMACYLIST = '/pharmacy-list';
  static const ORDERSPAGE = '/orders-page';
  static const CARTPAGE = '/cart-page';
  static const PAYPAGE = '/pay-page';

}
