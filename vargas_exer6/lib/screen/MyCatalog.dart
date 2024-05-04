import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import '../provider/shoppingcart_provider.dart';
import '../model/Item.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  List<Item> productsCatalog = [
    Item("Headband", 70.00, 2),
    Item("Lipstick", 210, 3),
    Item("Phonecase", 99, 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.storefront, size:28, color: Color.fromARGB(255, 136, 101, 141)),
              SizedBox(width: 15),
              Text(
                'Products Catalog',
                style: TextStyle(
                  fontSize: 21.0,
                  color: Color.fromARGB(255, 43, 43, 43),
                  fontFamily: 'CrimsonPro',
                ),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 225, 226, 224),
        ),
        body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.card_giftcard, size:20, color: Color.fromARGB(255, 141, 142, 141)),
                    title: Text(
                        "${productsCatalog[index].name}  -  \$${productsCatalog[index].price}",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Color.fromARGB(255, 43, 43, 43),
                          fontFamily: 'CrimsonPro',
                        ),
                      ),
                    trailing: TextButton(
                      child: const Icon(
                        Icons.add_box,
                        color: Color.fromARGB(255, 136, 101, 141),
                        size: 26 // Set icon color
                      ),
                      onPressed: () {
                        context
                            .read<ShoppingCart>()
                            .addItem(productsCatalog[index]);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${productsCatalog[index].name} was added to cart!"),
                            backgroundColor: Color.fromARGB(255, 112, 112, 112), // Set background color
                            behavior: SnackBarBehavior.floating, // Set behavior (floating or fixed)
                            elevation: 2, // Set elevation
                            shape: RoundedRectangleBorder( // Set border radius
                              borderRadius: BorderRadius.circular(16),
                            ),
                            duration: const Duration(seconds: 1),
                          ));
                      },
                    ),
                  ),
                  Divider(
                    color: Color.fromARGB(255, 202, 201, 167), // Change divider color
                    thickness: 1, // Change divider thickness
                    indent: 20, // Change left indent
                    endIndent: 20, // Change right indent
                    height: 10, // Change divider height
                  ),
                ],
              );
            },
            itemCount: productsCatalog.length),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.shopping_cart),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(255, 166, 149, 168), // Background color of the button
          elevation: 10, // Elevation of the button (shadow)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Shape of the button
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/cart");
          },
        ));
  }
}
