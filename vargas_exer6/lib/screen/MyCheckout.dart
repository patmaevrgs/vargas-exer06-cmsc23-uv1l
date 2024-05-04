import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCheckout extends StatelessWidget {
  const MyCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
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
          Flexible(
              child: Center(
                  child: Column(children: [
                    SizedBox(height: 20),
                    Text(
                      "Item Details", 
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color.fromARGB(255, 43, 43, 43),
                        fontFamily: 'CrimsonPro',
                      ),
                    ),
                    SizedBox(height: 20),
                    getItems(context)
          ]))),
        ],
      ),
    );
  }

  Widget getTotal() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text(
        "Total Cost:   \$ ${cart.cartTotal}",
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
        ? const Text(
          'No items to checkout!',
          style: TextStyle(
            fontSize: 17.0,
            color: Color.fromARGB(255, 43, 43, 43),
            fontFamily: 'CrimsonPro',
          ),
        )
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      products[index].name,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color.fromARGB(255, 43, 43, 43),
                        fontFamily: 'CrimsonPro',
                      ),
                    ),
                    trailing: Text(
                      "\$ ${products[index].price}",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color.fromARGB(255, 43, 43, 43),
                        fontFamily: 'CrimsonPro',
                      ),
                    ),
                  );
                },
              )),
              Flexible(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                    Divider(
                      color: Color.fromARGB(255, 202, 201, 167), // Change divider color
                      thickness: 1, // Change divider thickness
                      indent: 20, // Change left indent
                      endIndent: 20, // Change right indent
                      height: 10, // Change divider height
                    ),
                    SizedBox(height: 20),
                    getTotal(),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCart>().removeAll();
                          Navigator.pop(context, "/checkout");
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Payment Succesful!"),
                            backgroundColor: Color.fromARGB(255, 112, 112, 112), // Set background color
                            behavior: SnackBarBehavior.floating, // Set behavior (floating or fixed)
                            elevation: 2, // Set elevation
                            shape: RoundedRectangleBorder( // Set border radius
                              borderRadius: BorderRadius.circular(16),
                            ),
                            duration: Duration(seconds: 1),
                          ));
                        },
                        child: const Text(
                          "Pay Now!",
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 136, 101, 141),
                            fontFamily: 'CrimsonPro',
                          ),  
                        )),
                  ]))),
            ],
          ));
  }
}
