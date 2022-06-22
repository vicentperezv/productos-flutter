import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class AuthService extends ChangeNotifier{
   
   final String _baseUrl = 'identitytoolkit.googleapis.com';
   final String _firebaseToken = 'AIzaSyDQiLUxCFp977KEj84YddUx323Fu6dDzuQ';

   final storage = new FlutterSecureStorage();

   Future<String?> createUser( String email, String password ) async {
     
     final Map<String, dynamic> authData={
       'email': email,
       'password': password,
       'returnSecureToken': true
     };

     final url = Uri.https(_baseUrl, '/v1/accounts:signUp' ,{
       'key': _firebaseToken
     });

     final resp = await http.post(url, body: json.encode(authData));
     final Map<String,dynamic> decodedResp = json.decode(resp.body);

     if ( decodedResp.containsKey('idToken')){

       await storage.write(key: 'idToken', value: decodedResp['idToken']);

       return null;
     }else{
       return decodedResp['error']['message'];
     }
   }

   Future<String?> login( String email, String password ) async {
     
     final Map<String, dynamic> authData={
       'email': email,
       'password': password,
       'returnSecureToken': true
     };

     final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword' ,{
       'key': _firebaseToken
     });

     final resp = await http.post(url, body: json.encode(authData));
     final Map<String,dynamic> decodedResp = json.decode(resp.body);

     if ( decodedResp.containsKey('idToken')){
       
       await storage.write(key: 'idToken', value: decodedResp['idToken']);

       return null;
     }else{
       return decodedResp['error']['message'];
     }
   }

   Future logout() async {
     await storage.delete(key: 'idToken');
     return;
   }

   Future<String> readToken() async {
     return await storage.read(key: 'idToken') ?? '';
   }
}