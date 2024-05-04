// CMSC 23: State Management
// Task: Implement the checkout feature of the sample state management app from the lab class earlier.

// Submitted by: Patricia Mae I. Vargas
// Section: UV-1L

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/shoppingcart_provider.dart';
import 'screen/MyCart.dart';
import 'screen/MyCatalog.dart';
import 'screen/MyCheckout.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ShoppingCart()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/cart": (context) => const MyCart(),
        "/products": (context) => const MyCatalog(),
        "/checkout": (context) => const MyCheckout(),
      },
      home: const MyCatalog(),
    );
  }
}
