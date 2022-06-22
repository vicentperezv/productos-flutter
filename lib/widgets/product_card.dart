import 'package:flutter/material.dart';
import 'package:productos/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  const ProductCard({
    Key? key,
    required this.product
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child: Container(
        margin: EdgeInsets.only( top: 30, bottom: 30),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment:Alignment.bottomCenter,
          children: [
            _BackgroudImage(product: product),
            _ProductDetails(product: product,),
            Positioned(
              top:0,
              right: 0,
              child: _PriceTag(price: product.price.toString())
              ),
              if(!product.available)
                Positioned(
                  top:0,
                  left: 0,
                  child:_NotAvailable() 
                ), 
          ],
          )
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,5),
        blurRadius: 10 )
    ]
  );
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:10),
          child: Text('No disponible', style: TextStyle( color: Colors.white, fontSize:20)),
        ),
      ),
      width:100,
      height:70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.only( topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
      )
    );
  }
}

class _PriceTag extends StatelessWidget {
  final String price;
  const _PriceTag({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:10),
          child: Text('\$ $price', style: TextStyle( color: Colors.white, fontSize:20)),
        ),
      ),
      width:100,
      height:70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only( topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      )
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;
  const _ProductDetails({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only( right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical:10),
        width: double.infinity,
        height:70,
        decoration: _productDetailsDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name, style: TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            ),
            Text(product.id!, style: TextStyle( fontSize: 15, color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _productDetailsDecoration() => BoxDecoration(
    color: Colors.deepPurple,
    borderRadius: BorderRadius.only( bottomLeft: Radius.circular(25), topRight: Radius.circular(25)),
  );
}

class _BackgroudImage extends StatelessWidget {
  final Product product;
  const _BackgroudImage({
    Key? key,
    required this.product
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height:400,
        child: product.picture == null
          ? 
          Image(
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover
          )
          : 
          FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image:NetworkImage(product.picture!),
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}