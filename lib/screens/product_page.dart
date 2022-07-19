import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:menu_dodasi/screens/category_page.dart';
import 'package:menu_dodasi/screens/more_page.dart';

import '../cons/CustomAppBar.dart';
import '../cons/all_cons.dart';
import '../cons/colors/ColorConstants.dart';
import '../models/product_model.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/product-page';

  const ProductPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductData> products = [];
  final _chuckerHttpClient = ChuckerHttpClient(http.Client());

  Future<List<ProductData>?> _getCategories(int category_id, int lang) async {
    Map<String, String> header = {"autorization": AllCons.TOKEN};
    var categoryResponse = await _chuckerHttpClient.get(headers: header, Uri.parse("${AllCons.BASE_URL}${category_id}/products?lang=$lang"));
    Map<String, dynamic> body = jsonDecode(categoryResponse.body);
    ProductResponse category = ProductResponse.fromJson(body);

    if (kDebugMode) {
      print("category->${category.data}");
    }
    if (category.data != null) {
      products = category.data!;
      for (var value in products) {
        value.categoryId = category_id;
      }
      return products;
    } else {
      return <ProductData>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final lang = arg['lang'];
    final category_id = arg['category_id'];
    final String category_name = arg['category_name'];



    return SafeArea(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(category_name),
          body: Container(
            height: double.infinity,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(transform: GradientRotation(1.6), colors: [
                  Color.fromRGBO(255, 255, 255, 0.5019607843137255),
                  Color.fromRGBO(255, 255, 255, 0.9),
                  Color.fromRGBO(255, 255, 255, 0.8),
                ]),
              ),
              child: FutureBuilder(
                future: _getCategories(category_id ?? 0, lang ?? 0),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(child: Text('Loading ...')),
                    );
                  } else {
                    return Container(
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return productItem(products[index],lang);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          )),
    ));
  }

  int _count = 1;

  void _counter() {
    _count++;
    setState(() {
      // if (value == 1) {
      // } else if (value == 0) {
      //   if (_count > 0) _count--;
      // }
    });
  }
  Widget productItem(ProductData productData, lang) {

    Future dialog() => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) => Dialog(
        child: Container(
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Material(
                      color: ColorConstants.colorPrimary,
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 12),
                            child: Text(
                              'X',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              Center(
                  child: Text(
                    'Выберете кол-во',
                    style: TextStyle(fontFamily: 'Arsenal', fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: ColorConstants.colorPrimary,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: _counter,

                      child: Container(
                        padding: EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 8),
                        child: Text(
                          '-',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        '$_count',
                        style: TextStyle(fontFamily: 'Arsenal', color: ColorConstants.colorPrimaryAccent),
                      )),
                  Material(
                    color: ColorConstants.colorPrimary,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: _counter,
                      child: Container(
                        padding: EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 8),
                        child: Text(
                          '+',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 35, right: 35),
                    child: Material(
                      color: ColorConstants.colorPrimary,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          Navigator.popUntil(context, ModalRoute.withName(CategoryPage.routeName));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: Text('Вернуться в Меню', style: TextStyle(fontFamily: 'Arsenal', color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 35, right: 35),
                    child: Material(
                      color: ColorConstants.colorPrimary,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(
                              'В корзину',
                              style: TextStyle(fontFamily: 'Arsenal', color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      width: MediaQuery.of(context).size.width*0.6,
                      'images/dialog_background.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(settings: RouteSettings(arguments: "$lang"), builder: (context) => ProductPage()));
      },
      child: Card(
        elevation: 10,
        child: Container(
          // height: double.infinity,
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  height: 200,
                  fit: BoxFit.fill,
                  imageUrl: productData.productImage.toString(),
                  errorWidget: (context, url, error) => Image(image: AssetImage('images/logo_menu_dodasi.png')),
                  placeholder: (context, url) => productData.productImage == null
                      ? Image(image: AssetImage('images/logo_menu_dodasi.png'))
                      : Center(
                          child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                backgroundColor: Colors.white,
                                color: ColorConstants.colorPrimary,
                              ))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '${productData.productName?[0].toUpperCase()}${productData.productName?.substring(1).toLowerCase()}',
                  style: TextStyle(fontFamily: 'Arsenal', color: ColorConstants.colorPrimaryAccent),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '${productData.productDescription?[0].toUpperCase()}${productData.productDescription?.substring(1).toLowerCase().replaceAll('\r\n', ' ')}',
                  style: TextStyle(fontFamily: 'Arsenal', color: Colors.black, wordSpacing: 0),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 2, color: ColorConstants.colorPrimary)),
                child: Text(
                  productData.productPrice ?? "",
                  style: TextStyle(fontFamily: 'Arsenal', color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Material(
                  color: ColorConstants.colorPrimary,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () {
                      Map<String, dynamic> argument = productData.toJson();
                      argument['lang'] = lang;
                      Navigator.pushNamed(context, MorePage.routeName, arguments: argument);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Подробнее', style: TextStyle(fontFamily: 'Arsenal', color: Colors.white)),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    // decoration: BoxDecoration(),
                  ),
                ),
              ),
              Material(
                color: ColorConstants.colorPrimary,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: () =>  dialog(),
                  child: Container(
                    padding: EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 8),
                    child: Text(
                      '+',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomAppBar appBar(String category_name) {
    return CustomAppBar(
        height: 155,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(padding: EdgeInsets.only(left: 10), onPressed: () {}, icon: Icon(size: 30, Icons.search)),
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
                          "   ${category_name[0].toUpperCase()}${category_name.substring(1).toLowerCase()}   ",
                          style: const TextStyle(fontFamily: 'Arsenal', color: ColorConstants.colorPrimaryAccent, fontWeight: FontWeight.bold),
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
          ),
        ));
  }
}
