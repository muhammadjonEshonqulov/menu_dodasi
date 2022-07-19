import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_dodasi/cons/colors/ColorConstants.dart';

class SucceessfullyPage extends StatefulWidget {
  static const routeName = '/successfully-page';

  const SucceessfullyPage({Key? key}) : super(key: key);

  @override
  State<SucceessfullyPage> createState() => _SucceessfullyPageState();
}

class _SucceessfullyPageState extends State<SucceessfullyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.fill, image: AssetImage('images/background_menu_dodasi.png')),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(transform: GradientRotation(1.6), colors: [
                Color.fromRGBO(255, 255, 255, 0.5019607843137255),
                Color.fromRGBO(255, 255, 255, 0.9),
                Color.fromRGBO(255, 255, 255, 0.8),
              ]),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: ColorConstants.colorPrimary, width: 2), borderRadius: BorderRadius.circular(7)),
                width: double.infinity,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Image(
                    height: 200,
                    width: 200,
                    image: AssetImage('images/logo_menu_dodasi.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(color: ColorConstants.colorPrimary, width: 2), borderRadius: BorderRadius.circular(7)),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          "Спасибо за ваш выбор!",
                          style: TextStyle(
                            fontFamily: 'Arsenal',
                            color: ColorConstants.colorPrimaryAccent,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Заказ оформлен",
                          style: TextStyle(
                            fontFamily: 'Arsenal',
                            color: Colors.black,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.colorPrimary,
                      child: InkWell(
                        onTap: () => {},
                        child: Container(
                          padding: EdgeInsets.all(15),

                          child: Text(
                            'Вернуться в меню',
                            style: TextStyle(fontFamily: 'Arsenal', color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
