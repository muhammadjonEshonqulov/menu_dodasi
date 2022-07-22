import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_dodasi/models/product_model.dart';

import '../cons/all_cons.dart';
import '../cons/colors/ColorConstants.dart';
import '../screens/basket_page.dart';
import '../screens/category_page.dart';

class MoreView extends StatefulWidget {
  MoreView(this.productData, this.lang, {Key? key}) : super(key: key);

  ProductData productData;
  int lang;

  @override
  State<MoreView> createState() => _MoreViewState(productData, lang);
}

class _MoreViewState extends State<MoreView> {
  ProductData productData;
  int lang;
  int _count = 0;

  void _counter(value) {
    setState(() {
      if (value == 1) {
        _count++;
      } else if (value == 0) {
        if (_count > 0) _count--;
      }
    });
  }

  _MoreViewState(this.productData, this.lang);

  @override
  void initState() {
    _count = productData.productCount ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                      '${productData.productPrice} Сум',
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
                            onTap: () => _counter(0),
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
                            onTap: () => {_counter(1)},
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
      ],
    );
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
                                    Navigator.popUntil(context, ModalRoute.withName(CategoryPage.routeName));
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
                                    Navigator.pop(context);

                                    Map<String, dynamic> argument = {'category_id': categoryId, 'lang': lang};

                                    Navigator.pushNamed(context, BasketPage.routeName, arguments: argument);
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
}
