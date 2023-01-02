import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/homepage.dart';
import 'package:lottie/lottie.dart';
import 'Color/colors.dart' as NewColor;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logins.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primaryColor: NewColor.PrimaryColors(),
        primaryColorDark: NewColor.PrimaryColorsDark(),
        primarySwatch: Colors.brown,
        fontFamily: 'gotham'
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  void ChangePageHome(){
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.elasticInOut
              );
              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.center,
              );
            },
            pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation
                )
            {
              return homepage();
            }
        )
    );
  }
  void ChangePageLogin(){
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.elasticInOut
              );
              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.center,
              );
            },
            pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation
                )
            {
              return logins();
            }
        )
    );
  }
  Checker() async{
    final prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('name');
    if(name !=null){
      ChangePageHome();
    }else{
      Timer(Duration(seconds: 5),
          ChangePageLogin
      );
    }
  }
  @override
  void initState() {
    // Get.to(logins);
    super.initState();
    // Obtain shared preferences.
    Checker();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'gotham'),
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                color: NewColor.SecondaryColors(),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Lottie.asset("assets/lottie/loading.json"),
                    Center(
                      child: Lottie.asset(
                        "assets/lottie/loading.json",
                        width: 400,
                        height: 400,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Welcome To Kopi Lancong Apps",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: NewColor.PrimaryColors()
                        ),
                      ),

                    )
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("GeeksForGeeks")),
      body: Center(
          child:Text("Home page",textScaleFactor: 2,)
      ),
    );
  }
}
