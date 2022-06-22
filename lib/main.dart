import 'package:flutter/material.dart';
import 'package:productos/routes/app_routes.dart';
import 'package:productos/service/services.dart';
import 'package:provider/provider.dart';

void main() => runApp( AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => ProductsService())
      ],
      child: MyApp(),
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: AppRoute.initalRoute,
      routes: AppRoute.getAppRoutes(),
      scaffoldMessengerKey: NotificationService.messagerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.deepPurple,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          backgroundColor: Colors.deepPurple,
        )
      )
    );
  }
}