import 'package:flutter/cupertino.dart';
import 'package:productos/models/models.dart';
import 'package:productos/screens/screens.dart';

class AppRoute{

  static const String initalRoute = CheckAuthScreen.routerName;

  static final menuOptions = <MenuOption>[
    MenuOption(name: 'home', route: HomeScreen.routerName, screen: const HomeScreen()),
    MenuOption(name: 'login', route: LoginScreen.routerName, screen: const LoginScreen()),
    MenuOption(name: 'product', route: ProductScreen.routerName, screen: const ProductScreen()),
    MenuOption(name: 'register', route: RegisterScreen.routerName, screen: const RegisterScreen()),
    MenuOption(name: 'check', route: CheckAuthScreen.routerName, screen: const CheckAuthScreen()),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes(){
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for( final option in menuOptions ){
      appRoutes.addAll({option.route : (BuildContext context) => option.screen });
    }
    return appRoutes;
  }
}