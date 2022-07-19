import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:menu_dodasi/models/product_model.dart';
import 'package:menu_dodasi/screens/basket_page.dart';

import '../cons/CustomAppBar.dart';
import '../cons/colors/ColorConstants.dart';

class MorePage extends StatefulWidget {
  static const routeName = '/more-page';

  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final ProductData productData = ProductData.fromJson(arg);
    var count = 1;
    final lang  = arg['lang'];

    return SafeArea(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: appBar('${productData.productName} '),
          body: Container(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: ColorConstants.colorPrimary, width: 1.5), borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: CachedNetworkImage(
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width,
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
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            '${productData.productName?[0].toUpperCase()}${productData.productName?.substring(1).toLowerCase()}',
                            style: TextStyle(fontFamily: 'Arsenal', color: ColorConstants.colorPrimaryAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 1.5,
                          child: Container(
                            color: ColorConstants.colorPrimary,
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 7, bottom: 7, right: 7),
                        child: Text(
                          '${productData.productDescription?[0].toUpperCase()}${productData.productDescription?.substring(1).toLowerCase().replaceAll('\r\n', ' ')}',
                          style: TextStyle(fontFamily: 'Arsenal', color: Colors.black, wordSpacing: 0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 2, color: ColorConstants.colorPrimary)),
                        child: Text(
                          productData.productPrice ?? "",
                          style: TextStyle(fontFamily: 'Arsenal', color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Material(
                              color: ColorConstants.colorPrimary,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () {},
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
                                  '$count',
                                  style: TextStyle(fontFamily: 'Arsenal', color: ColorConstants.colorPrimaryAccent),
                                )),
                            Material(
                              color: ColorConstants.colorPrimary,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () {
                                  count++;
                                },
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
                      Material(
                        color: ColorConstants.colorPrimary,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                        child: InkWell(
                          onTap: () => dialog(productData.categoryId, lang),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(12),
                            child: Center(
                                child: Text(
                              'Выбрать',
                              style: TextStyle(color: Colors.white, fontFamily: 'Arsenal'),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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

  Future dialog(int? categoryId, lang) => showDialog(
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
                          'Добавлено в корзину',
                          style: TextStyle(fontFamily: 'Arsenal', fontWeight: FontWeight.bold),
                        )),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, left: 35, right: 35),
                              child: Material(
                                color: ColorConstants.colorPrimary,
                                borderRadius: BorderRadius.circular(5),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.popUntil(context, ModalRoute.withName(CategoryPage.routeName));
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                      child: Text(
                                        'Вернуться в Меню',
                                        style: TextStyle(fontFamily: 'Arsenal', color: Colors.white),
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
                                  onTap: () {
                                    Map<String, dynamic> argument = {'category_id': categoryId,'lang': lang};

                                    Navigator.pushNamed(context, BasketPage.routeName,arguments: argument);
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                      child: Text(
                                        'Просмотреть корзину',
                                        style: TextStyle(fontFamily: 'Arsenal', color: Colors.white),
                                      )),
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
