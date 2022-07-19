import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:menu_dodasi/cons/all_cons.dart';
import 'package:menu_dodasi/screens/product_page.dart';

import '../cons/CustomAppBar.dart';
import '../cons/colors/ColorConstants.dart';
import '../models/category_model.dart';

class CategoryPage extends StatefulWidget {
  static const routeName = '/category-page';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategoryData> categories = [];

  final _chuckerHttpClient = ChuckerHttpClient(http.Client());

  Future<List<CategoryData>?> _getCategories(int lang) async {
    Map<String, String> header = {"autorization": AllCons.TOKEN};
    var categoryResponse = await _chuckerHttpClient.get(headers: header, Uri.parse("${AllCons.BASE_URL}category?lang=$lang"));
    Map<String, dynamic> body = jsonDecode(categoryResponse.body);
    CategoryResponse category = CategoryResponse.fromJson(body);

    if (kDebugMode) {
      print("category->${category.data}");
    }
    if (category.data != null) {
      categories = category.data!;
      return categories;
    } else {
      return <CategoryData>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    final lang = arg['lang'];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // navigatorObservers: [ChuckerFlutter.navigatorObserver],
      home: SafeArea(
          child: Scaffold(
              appBar: appBar(),
              body: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(transform: GradientRotation(1.6), colors: [
                    Color.fromRGBO(255, 255, 255, 0.5019607843137255),
                    Color.fromRGBO(255, 255, 255, 0.9),
                    Color.fromRGBO(255, 255, 255, 0.8),
                  ]),
                ),
                child: FutureBuilder(
                  future: _getCategories(lang ?? 0),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Loading ...'));
                    } else if (snapshot.connectionState != ConnectionState.done) {
                      return Center(child: Text('done'));
                    } else if (snapshot.data == null) {
                      return Center(child: Text('snapshot.data == ${snapshot.data}'));
                    } else {
                      return MasonryGridView.count(
                        crossAxisCount: 2,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return categoryItem(categories[index], lang);
                        },
                      );
                    }
                  },
                ),
              ))),
    );
  }

  Widget categoryItem(CategoryData categoryData, int? lang) {
    return InkWell(
      onTap: () {
        Map<String, dynamic> argument = {'category_id': categoryData.categoryId ?? 0, 'category_name': categoryData.categoryName, 'lang': lang ?? 0};
        Navigator.pushNamed(context, ProductPage.routeName, arguments: argument);
      },
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: ColorConstants.colorPrimary, width: 2), borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Center(
                child: CachedNetworkImage(
                  height: 200,
                  imageUrl: categoryData.categoryPhoto.toString(),
                  errorWidget: (context, url, error) => Image(image: AssetImage('images/logo_menu_dodasi.png')),
                  placeholder: (context, url) => categoryData.categoryPhoto == null ? Image(image: AssetImage('images/logo_menu_dodasi.png')) : Center(child: SizedBox(width: 40,height: 40, child: CircularProgressIndicator(strokeWidth: 2,backgroundColor: Colors.white,color: ColorConstants.colorPrimary,))),
                ),
              ),
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ColorConstants.colorPrimary, width: 2), borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        '${categoryData.categoryName?[0].toUpperCase()}${categoryData.categoryName?.substring(1).toLowerCase()}',
                        style: TextStyle(fontFamily: 'Arsenal', color: ColorConstants.colorPrimary),
                      ),
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

  CustomAppBar appBar() {
    return CustomAppBar(
        height: 152,
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 1),
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
              Container(
                child: Row(
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
                            style: TextStyle(fontFamily: 'Arsenal', color: ColorConstants.colorPrimaryAccent, fontWeight: FontWeight.bold),
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
              ),
            ],
          ),
        ));
  }
}
