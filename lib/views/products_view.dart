import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:menu_dodasi/models/product_model.dart';
import 'package:menu_dodasi/screens/basket_page.dart';
import 'package:menu_dodasi/screens/category_page.dart';
import 'package:menu_dodasi/screens/more_page.dart';
import 'package:menu_dodasi/views/all_product_count_listener.dart';

import '../cons/all_cons.dart';
import '../cons/colors/ColorConstants.dart';

class ProductsView<T> extends StatefulWidget {
  ProductsView(
    this.products,
    this.lang,
    this.action,
    this.sendCount, {
    Key? key,
  }) : super(key: key);

  List<ProductData> products;
  int lang;
  Future<T> Function(Map argument) action;
  Future<T> Function(ProductData productData) sendCount;


  @override
  State<ProductsView> createState() => _ProductsViewState(products, lang, action, sendCount);
}

void navigateToMore(argument, context) {
  Navigator.pushNamed(context, MorePage.routeName, arguments: argument);
}

class _ProductsViewState<T> extends State<ProductsView> {
  _ProductsViewState(this.products, this.lang, this.action, this.sendCount);

  int lang;
  List<ProductData> products;
  Future<T> Function(Map argument) action;
  Future<T> Function(ProductData productData) sendCount;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return productItem(products[index], lang);
      },
    );
  }

  Widget productItem(ProductData productData, lang) {
    int _count = 0;

    if (productData.productCount != null) {
      _count = productData.productCount ?? 0;
    }

    Future dialog(lang) => showDialog(
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
                                  onTap: () {
                                    setState(() {
                                      if (_count > 0) _count--;
                                      productData.productCount = _count;
                                    });
                                  },
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
                                  onTap: () {
                                    setState(() {
                                      _count++;
                                      productData.productCount = _count;
                                    });
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
                                margin: const EdgeInsets.only(top: 20, left: 35, right: 35),
                                child: Material(
                                  color: ColorConstants.colorPrimary,
                                  borderRadius: BorderRadius.circular(5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Map<String, dynamic> argument = {'category_id': productData.categoryId, 'lang': lang};
                                      Navigator.pushNamed(context, BasketPage.routeName, arguments: argument);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                                        child: const Text(
                                          'В корзину',
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
    return Material(
      child: InkWell(
        onTap: () {
          navigateToMore("argument", context);
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
                        ? const Image(image: AssetImage('images/logo_menu_dodasi.png'))
                        : const Center(
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
                    '${productData.productPrice} Сум',
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
                        argument.putIfAbsent('lang', () => lang);
                        action(argument);
                        prt('print');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: ColorConstants.colorPrimary,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () => dialog(lang).then((value) {
                          setState(() {
                            _count;
                          });
                          sendCount(productData);
                        }),
                        child: Container(
                          padding: EdgeInsets.only(left: 13, right: 13, top: 8, bottom: 8),
                          child: Text(
                            '+',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _count == 0 ? '' : 'X$_count',
                        // productData.productCount == 0 ?'':'X${productData.productCount}',
                        style: TextStyle(fontFamily: 'Arsenal', color: Color.fromRGBO(220, 185, 0, 1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
