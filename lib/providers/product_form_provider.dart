
import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';

class ProductFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider( this.product );

  updateAvaliable( bool value ){
    this.product.available = value;
    notifyListeners();
  }

  bool isValid(){
    return formKey.currentState?.validate() ?? false;
  }
}