import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:menu_dodasi/models/AllOrderBody.dart';
import 'package:menu_dodasi/models/OrderBody.dart';
import 'package:menu_dodasi/screens/successfully_page.dart';

import '../cons/CustomAppBar.dart';
import '../cons/all_cons.dart';
import '../cons/colors/ColorConstants.dart';
import '../models/product_model.dart';
import 'category_page.dart';
import 'more_page.dart';
import 'package:http/http.dart' as http;

class BasketPage extends StatefulWidget {
  static const routeName = '/basket-page';

  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  List<ProductData> products = [];
  AllOrderBody? allOrderBody;
  final _chuckerHttpClient = ChuckerHttpClient(http.Client());

   Future<List<ProductData>?> _sendOrders(int lang, int table_id, int waiter_id, OrderBody orderBody) async {

    Map<String, String> header = {"autorization": AllCons.TOKEN};
    var categoryResponse = await _chuckerHttpClient.post(headers: header, Uri.parse("${AllCons.BASE_URL}orders?lang=$lang&table_id=$table_id&waiter_id=$waiter_id"),body:orderBody );
    Map<String, dynamic> body = jsonDecode(categoryResponse.body);

    ProductResponse category = ProductResponse.fromJson(body);
    prt('categoryResponse.body -> ${categoryResponse.body}');

  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final lang = arg['lang'];
    final categoryId = arg['category_id'];
    allOrderBody = arg['AllOrderBody'] as AllOrderBody;
    if(allOrderBody?.allOrders.values != null){
      products.clear();
      products.addAll(allOrderBody!.allOrders.values);
    }

    return SafeArea(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      // navigatorObservers: [ChuckerFlutter.navigatorObserver],
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill, image: AssetImage('images/background_menu_dodasi.png'))),

            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(transform: GradientRotation(1.6), colors: [
                  Color.fromRGBO(255, 255, 255, 0.4),
                  Color.fromRGBO(255, 255, 255, 0.9),
                  Color.fromRGBO(255, 255, 255, 0.8),
                ]),
              ),

              child: Column(
                children: [
                  appBar(),
                  Expanded(
                    flex: 8,
                    child: Container(
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
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return productItem(products[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorConstants.colorPrimary),
                        child: Column(
                          children: [
                            Text('0 сум + 15% обслуживание', style: TextStyle(fontFamily: 'Arsenal', color: Colors.white, fontWeight: FontWeight.bold)),
                            Container(
                              height: 1,
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              width: 170,
                              color: Colors.white,
                            ),
                            Text('Всего: 0 сум', style: TextStyle(fontFamily: 'Arsenal', color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.colorPrimary,
                          child: InkWell(
                            onTap: () => {if (products.length > 0) dialog() else snackAction(context,'svsdvsdvs')},
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(),
                              child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Image(image: AssetImage('images/ic_order.png'), width: 20),
                                  Container(padding: EdgeInsets.only(left: 5), child: Text('Заказать', style: TextStyle(fontFamily: 'Arsenal', color: Colors.white, fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
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

  final _tableAndWaiterIdKey = GlobalKey<FormState>();

  Future dialog() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) => Dialog(
                  child: Container(
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(3.0),
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
                          'Подтвердите заказ',
                          style: TextStyle(fontFamily: 'Arsenal', fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20, left: 35,right: 35),
                              child: Form(
                                key: _tableAndWaiterIdKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (table_id) {
                                        if (table_id == null || table_id.isEmpty) {
                                          return 'Введите номер стола';
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                      style: TextStyle(fontFamily: 'Arsenal'),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                        border: UnderlineInputBorder(),
                                        labelText: 'Введите номер стола',
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: TextFormField(
                                        validator: (waiter_id) {
                                          if (waiter_id == null || waiter_id.isEmpty) {
                                            return 'Введите ID официанта';
                                          }
                                        },
                                        style: TextStyle(fontFamily: 'Arsenal'),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Введите ID официанта',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20, ),
                                      child: Material(
                                        color: ColorConstants.colorPrimary,
                                        borderRadius: BorderRadius.circular(5),
                                        child: InkWell(
                                          onTap: () {
                                            if (_tableAndWaiterIdKey.currentState!.validate()) {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(context, SucceessfullyPage.routeName);
                                            }
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only( top: 10, bottom: 10),
                                              child: Text(
                                                'Заказать',
                                                style: TextStyle(fontFamily: 'Arsenal', color: Colors.white),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                width: MediaQuery.of(context).size.width * 0.6,
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

  Widget productItem(ProductData productData) {
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
                alignment: Alignment.centerLeft,
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
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(width: 1.5, color: ColorConstants.colorPrimary)),
                child: Text(
                  '${productData.productPrice} Сум',
                  style: TextStyle(fontFamily: 'Arsenal', color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Material(
                          color: ColorConstants.colorPrimary,
                          borderRadius: BorderRadius.circular(40),
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              padding: EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 8),
                              child: Text(
                                '+',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Material(
                          color: ColorConstants.colorPrimary,
                          borderRadius: BorderRadius.circular(40),
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                              child: Text(
                                '-',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'X${productData.productCount}',
                        style: TextStyle(fontFamily: 'Arsenal', color: Color.fromRGBO(220, 185, 0, 1)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
        height: 162,
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.colorPrimary,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);

                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0, right: 3),
                              child: Image.asset(width: 25, color: Colors.white, 'images/left_forward.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Назад',
                                style: TextStyle(fontFamily: 'Arsenal', color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(child: Image(height: 100, image: AssetImage('images/logo_menu_dodasi.png'))),
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
                          "   Корзина   ",
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
