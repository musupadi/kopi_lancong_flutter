import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/API/server.dart';
import 'package:kopi_lancong_latihan/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:kopi_lancong_latihan/ui/Cashier/cashier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_formatter/money_formatter.dart';
import '../logins.dart';

String CalculateCurrency(String number){
  String Bayar = number.substring(3);
  String result = Bayar.replaceAll(".", "");
  return result;
}
FailedMessage (String title,String desc,BuildContext context){
  AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnOkOnPress: () {

      },
      headerAnimationLoop: false
  )..show();
}
void Logout(BuildContext context) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  String id = pref.getString("id")!;
  String username = pref.getString("level")!;
  String name = pref.getString("name")!;
  // FailedMessage("Contoh ", name.toString(), context);

  await pref.clear();

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
Future<String?> NamaSession() async{
  final prefs = await SharedPreferences.getInstance();
  String? name = await prefs.getString('name');
  return name.toString();
}
Future<String?> IDSession() async{
  final prefs = await SharedPreferences.getInstance();
  String? id = await prefs.getString('id');
  return id.toString();
}
LogoutMessage (String title,String desc,BuildContext context){
  AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        Logout(context);
      },
      btnCancelOnPress: (){

      },
      headerAnimationLoop: false
  )..show();
}
String MoneyFormat(double amount){
  MoneyFormatter fmf = new MoneyFormatter(
      amount: amount,
      settings: MoneyFormatterSettings(
          symbol: 'IDR',
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 0,
          compactFormatType: CompactFormatType.short
      )
  );
  return fmf.output.nonSymbol;
}
ToCashier (BuildContext context){
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
              alignment: Alignment.centerLeft,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return cashier();
          }
      )
  );
}
ToHome (BuildContext context){
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
              alignment: Alignment.centerRight,
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
