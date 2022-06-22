import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';
import 'package:productos/screens/screens.dart';
import 'package:productos/service/services.dart';
import 'package:productos/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  static const String routerName = "home";
  
  
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context);

    if( productsService.isLoading ) return LoadingScreen();
    
    return Scaffold(
      appBar: AppBar(
        title:Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: (){
              authService.logout();
              Navigator.pushReplacementNamed(context, LoginScreen.routerName);
            }
          )
        ],
        ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ( BuildContext context , int index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, ProductScreen.routerName);
            },
          child: ProductCard(product: productsService.products[index],))
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon( Icons.add),
          onPressed: (){

            productsService.selectedProduct = new Product(
              available: false,
              name: '',
              price: 0,              
            );
            Navigator.pushNamed(context, ProductScreen.routerName);
          },
        ),
    );
  }
}