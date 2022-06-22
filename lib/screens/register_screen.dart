import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos/providers/login_form_provider.dart';
import 'package:productos/screens/screens.dart';
import 'package:productos/service/services.dart';
import 'package:productos/ui/input_decorations.dart';
import 'package:productos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routerName = "register";
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
         child: AuthBackground(
           child: SingleChildScrollView(
             child: Column(
               children: [
                 SizedBox( height: 250),
                 CardContainer(
                   child: Column(
                     children: [
                       SizedBox( height: 10),
                       Text('Registrar', style: Theme.of(context).textTheme.headline5),
                       SizedBox( height: 10),
                       ChangeNotifierProvider( 
                         create: ( _ ) => LoginFormProvider(),
                         child: _Login()
                       ),
                       
                     ]
                   )),
                  SizedBox(height:50),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routerName),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all( Colors.deepPurple.withOpacity(0.1)),
                      shape: MaterialStateProperty.all( StadiumBorder() ),
                    ),
                    child:  Text('¿Ya tienes una cuenta?', style: TextStyle( fontSize: 18, color: Colors.black87))
                  ),
                  SizedBox(height:50),
               ],)
           ),),
      ),
    );
  }
}

class _Login extends StatelessWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key:  loginForm.formKey,
       
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputsDecorations.authInputDecorations( hintText: 'example@mail.com', labelText: 'Correo' , prefixIcon: Icons.alternate_email),
              onChanged: ( value ) => loginForm.email = value,
              validator: ( value ){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch(value ?? '') ? null : 'El correo no es valido';
              },
            ),
            SizedBox( height: 30),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autocorrect: false,
              obscureText: true,              
              decoration: InputsDecorations.authInputDecorations( hintText: '*******', labelText: 'Contraseña' , prefixIcon: Icons.lock_outline),
              onChanged: ( value ) => loginForm.password = value,

              validator: ( value ){
              
                return (value != null && value.length >=6) ? null : 'La contraseña debe tener más de 6 caracteres';
              },
            ),
            SizedBox( height: 30),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(loginForm.isLoading ?'Espere...':'Registrar',
                style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ),
              onPressed:loginForm.isLoading? null : () async{
                final authService = Provider.of<AuthService>(context, listen: false);
                if(!loginForm.isValidForm()) return;

                loginForm.isLoading=true;
                
                final String? error = await authService.createUser(loginForm.email, loginForm.password);

                if( error == null ){
                  Navigator.pushReplacementNamed(context, HomeScreen.routerName);
                }else{
                  NotificationService.showSnackBar('Email ya existente');
                  loginForm.isLoading=false;
                }
                
                
              })
          ],) )
    );
  }
}