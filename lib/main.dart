import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:menu_dodasi/screens/basket_page.dart';
import 'package:menu_dodasi/screens/category_page.dart';
import 'package:menu_dodasi/screens/login_page.dart';
import 'package:menu_dodasi/screens/more_page.dart';
import 'package:menu_dodasi/screens/product_page.dart';
import 'package:menu_dodasi/screens/successfully_page.dart';

void main() {
  // ChuckerFlutter.showOnRelease = true;
  ChuckerFlutter.isDebugMode = true;
  ChuckerFlutter.showOnRelease = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (ctx) => const LoginPage(),
        CategoryPage.routeName: (ctx) => const CategoryPage(),
        ProductPage.routeName: (ctx) => const ProductPage(),
        MorePage.routeName: (ctx) => const MorePage(),
        BasketPage.routeName: (ctx) => const BasketPage(),
        SucceessfullyPage.routeName: (ctx) => const SucceessfullyPage(),
      },
    );
  }
}
