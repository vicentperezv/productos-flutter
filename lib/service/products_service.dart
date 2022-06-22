import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos/models/models.dart';
import 'package:http/http.dart' as http; 

class ProductsService extends ChangeNotifier{

    final String _baseUrl ='flutter-productos-curso-2f1fd-default-rtdb.firebaseio.com';

    final List<Product> products=[];
    late Product selectedProduct;
    bool isLoading = true;
    bool isSaving = false;

    final storage = new FlutterSecureStorage();

    File? newPictureFile;

    ProductsService(){
      this.loadProducts();
    }

    Future <List<Product>> loadProducts() async {

      this.isLoading = true;
      notifyListeners();

      final url = Uri.https( _baseUrl, 'products.json', {
        'auth': await storage.read(key: 'idToken') ?? ''
      });
      final resp = await http.get( url );
      final Map<String, dynamic> productsMap = json.decode( resp.body );

      productsMap.forEach((key, value) {
        final tempProduct = Product.fromMap( value );
        tempProduct.id = key;
        this.products.add( tempProduct );

      });

      this.isLoading = false;
      notifyListeners();
      return this.products;
    }

    Future saveOrCreateProduct( Product product )async{
      isSaving = true;
      notifyListeners();
    
      if( product.id == null){
        await this.createProduct(product);
      }else{
        await this.updateProduct(product);
      }
    
      isSaving = false;
      notifyListeners();
    }

    Future<String> updateProduct( Product product) async{
      final url = Uri.https( _baseUrl, 'products/${product.id}.json',{
        'auth': await storage.read(key: 'idToken') ?? ''
      } );
      final resp = await http.put( url, body: product.toJson() );
      final decodeData = resp.body;
      
      final index = this.products.indexWhere(( element ) => element.id == product.id);
      this.products[index] = product;
      return product.id!;


    }

    Future<String> createProduct( Product product) async{
      final url = Uri.https( _baseUrl, 'products.json',{
        'auth': await storage.read(key: 'idToken') ?? ''
      } );
      final resp = await http.put( url, body: product.toJson() );
      final decodeData = json.decode( resp.body );
      
      product.id = decodeData['name'];
      this.products.add( product );

      return product.id!;
    }

    void updateSelectedProductImage( String path ){

      this.selectedProduct.picture = path;
      this.newPictureFile = File.fromUri( Uri(path: path) );

      notifyListeners();
    }

    Future<String?> uploadImage()async{

      if( this.newPictureFile == null ) return null;

      this.isSaving = true;
      notifyListeners();

      final url = Uri.parse('https://api.cloudinary.com/v1_1/dv8l6sie5/image/upload?upload_preset=ml_default');

      final imageUploadRequest = http.MultipartRequest('POST', url);

      final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

      imageUploadRequest.files.add(file);

      final stremResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(stremResponse);

      if( resp.statusCode != 200 && resp.statusCode !=201 ){
        return null;
      }

      this.newPictureFile = null;

      final decodeData = json.decode( resp.body );
      return decodeData['secure_url'];

     
    }
}
