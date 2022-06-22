import 'package:flutter/material.dart';
import 'package:productos/screens/screens.dart';
import 'package:productos/service/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  static const String routerName = "check";
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>( context, listen: false);

    return Scaffold(
      body: Center(
         child: FutureBuilder(
           future: authService.readToken(),           
           builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
             if( !snapshot.hasData )
              return  CircularProgressIndicator(color: Colors.deepPurple,);
            
             if( snapshot.data == ''){
               Future.microtask(() {
               Navigator.pushReplacement(context, PageRouteBuilder(
                 pageBuilder: (_ , __ , ___) => LoginScreen(),
                 transitionDuration: Duration( seconds:  0)
                )
              );
             });
             }else{
               Future.microtask(() {
               Navigator.pushReplacement(context, PageRouteBuilder(
                 pageBuilder: (_ , __ , ___) => HomeScreen(),
                 transitionDuration: Duration( seconds:  0)
                )
              );
             });
             }
             

              return Container();
             }
         ) 
      ),
    );
  }
}