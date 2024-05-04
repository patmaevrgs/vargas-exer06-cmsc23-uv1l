import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        "My Cart",
        style: TextStyle(
          fontSize: 21.0,
          color: Color.fromARGB(255, 43, 43, 43),
          fontFamily: 'CrimsonPro',
        ),
      ),
      backgroundColor: Color.fromARGB(255, 225, 226, 224),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
          Divider(
            color: Color.fromARGB(255, 202, 201, 167), // Change divider color
            thickness: 1, // Change divider thickness
            indent: 20, // Change left indent
            endIndent: 20, // Change right indent
            height: 10, // Change divider height
          ),
          SizedBox(height: 20),
          getTotal(),
          Flexible(
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                    ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCart>().removeAll();
                        },
                        child: const Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 136, 101, 141),
                            fontFamily: 'CrimsonPro',
                          ),  
                        )),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, "/checkout");
                      },
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 136, 101, 141),
                          fontFamily: 'CrimsonPro',
                        ), 
                      )
                    ),
                ]))),
          TextButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, size: 20, color: Color.fromARGB(255, 134, 133, 110)), // Icon
                SizedBox(width: 10), // Spacer between icon and text
                Text(
                  'Back to Product Catalog',
                  style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 134, 133, 110),
                  fontFamily: 'CrimsonPro',
                )),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/products");
            },
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget getTotal(){
     return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text(
        "Total:   \$${cart.cartTotal}",
        style: TextStyle(
          fontSize: 17.0,
          color: Color.fromARGB(255, 43, 43, 43),
          fontFamily: 'CrimsonPro',
        ),
      );
    });
  }


  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty
        ? const Column(
          children: [
            SizedBox(height: 30),
            Text(
              'No Items yet!',
              style: TextStyle(
                fontSize: 17.0,
                color: Color.fromARGB(255, 43, 43, 43),
                fontFamily: 'CrimsonPro',
              ),
            ),
            SizedBox(height: 30),
          ],
        )
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.card_giftcard, size:20, color: Color.fromARGB(255, 141, 142, 141)),
                    title: Row(
                      children: [
                        Text(
                          products[index].name,
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 43, 43, 43),
                            fontFamily: 'CrimsonPro',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text("-"),
                        SizedBox(width: 10),
                        Text(
                          '\$${products[index].price.toString()}',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 43, 43, 43),
                            fontFamily: 'CrimsonPro',
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel, size:26,color: Color.fromARGB(255, 136, 101, 141)),
                      onPressed: () {
                        productname = products[index].name;
                        context.read<ShoppingCart>().removeItem(productname);

                        if (products.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$productname was removed from cart!"),
                            backgroundColor: Color.fromARGB(255, 112, 112, 112), // Set background color
                            behavior: SnackBarBehavior.floating, // Set behavior (floating or fixed)
                            elevation: 2, // Set elevation
                            shape: RoundedRectangleBorder( // Set border radius
                              borderRadius: BorderRadius.circular(16),
                            ),
                            duration: Duration(seconds: 1),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text("Cart Empty!"),
                            backgroundColor: Color.fromARGB(255, 112, 112, 112), // Set background color
                            behavior: SnackBarBehavior.floating, // Set behavior (floating or fixed)
                            elevation: 2, // Set elevation
                            shape: RoundedRectangleBorder( // Set border radius
                              borderRadius: BorderRadius.circular(16),
                            ),
                            duration: Duration(seconds: 1),
                          ));
                        }
                      },
                    ),
                  );
                },
              )),
              ],
          ));
  }
}
