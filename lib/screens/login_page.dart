import 'package:flutter/material.dart';
import 'package:menu_dodasi/screens/category_page.dart';

import '../cons/colors/ColorConstants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('images/auth_back_image.png'))),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(transform: GradientRotation(1.6), colors: [
              Colors.black,
              Color.fromRGBO(0, 0, 0, 0.9),
              Color.fromRGBO(0, 0, 0, 0.8),
            ]),
          ),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                border:
                    Border.all(color: ColorConstants.colorPrimary, width: 1)),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 150, bottom: 100),
                child: Column(children: [
                  Center(
                    child: Image(
                      height: 200,
                      width: 200,
                      image: AssetImage('images/logo_menu_dodasi.png'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstants.colorPrimary,
                                    width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Добро пожаловать !",
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
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Выберите язык",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  Material(
                    color: ColorConstants.colorPrimary,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(arguments: "2"),
                                builder: (context) => const CategoryPage()));
                      },
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 10),
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Image(
                                image: AssetImage("images/flag_uzb.png"),
                                width: 30,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Ўзбек тили',
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Material(
                    color: ColorConstants.colorPrimary,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                settings: RouteSettings(arguments: "3"),
                                builder: (context) => const CategoryPage()));
                      },
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 10),
                        child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Image(
                                image: AssetImage("images/flag_russian.png"),
                                width: 30,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Русский язык',
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
