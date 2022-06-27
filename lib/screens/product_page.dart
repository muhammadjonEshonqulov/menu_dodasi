import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';

import '../cons/CustomAppBar.dart';
import '../cons/all_cons.dart';
import '../cons/colors/ColorConstants.dart';
import '../models/category_model.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductData> products = [];
  final lang = 3;
  var category_id = -1;

  void getCategories(String lang) async {
    Map<String, String> header = {"autorization": "a69fa0e1dd3d5c2c77cb4d3f0adde901"};
    final categoryResponse = await ChuckerHttpClient(http.Client()).get(headers: header, Uri.parse("${AllCons.BASE_URL}${category_id}/products?lang=$lang"));
    final Map<String, dynamic> body = jsonDecode(categoryResponse.body);
    final ProductResponse product = ProductResponse.fromJson(body);
    setState(() {
      products = product.data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = ModalRoute.of(context)?.settings.arguments as String;

    return SafeArea(
        child: Scaffold(
            appBar: appBar(),
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('images/main_back_image.png'))),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(transform: GradientRotation(1.6), colors: [
                    Colors.black,
                    Color.fromRGBO(0, 0, 0, 0.9),
                    Color.fromRGBO(0, 0, 0, 0.8),
                  ]),
                ),
                child: Container(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return productItem(products[index]);
                    },
                  ),
                ),
              ),
            )));
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getCategories();
  // }

  Widget productItem(ProductData productData) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(border: Border.all(color: ColorConstants.colorPrimary, width: 1)),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: productData.productImage.toString(),
              placeholder: (context, url) => productData.productImage != null ? CircularProgressIndicator() : Image.asset('images/logo_menu_dodasi.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: ColorConstants.colorPrimary, borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Text(
                  productData.productName ?? "",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomAppBar appBar() {
    return CustomAppBar(
        child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(padding: EdgeInsets.only(left: 10), onPressed: () {}, icon: Icon(size: 30, color: Colors.white, Icons.search)),
            Image(height: 100, image: AssetImage('images/logo_menu_dodasi.png')),
            IconButton(padding: EdgeInsets.only(right: 10), onPressed: () {}, icon: Image.asset(height: 30, 'images/korzinka.png')),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: ColorConstants.colorPrimary,
                height: 1,
              ),
            ),
            Center(
              child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  decoration: BoxDecoration(border: Border.all(color: ColorConstants.colorPrimary, width: 1), borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    "   Меню   ",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: ColorConstants.colorPrimary,
                height: 1,
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
