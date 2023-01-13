import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Color/colors.dart' as NewColor;
import 'package:kopi_lancong_latihan/Model/Ascendant.dart';
import 'package:kopi_lancong_latihan/Model/Cashier.dart';
import 'package:kopi_lancong_latihan/SharedPreference/db_helper.dart';
import 'package:kopi_lancong_latihan/ui/Cashier/cashier.dart';
import 'package:intl/intl.dart';

class adaptercart extends StatefulWidget {
  String id;
  String img;
  String nama;
  String price;
  String items;
  String totalharga;
  adaptercart({Key? key,required this.img,required this.nama,required this.price,required this.id,required this.items,required this.totalharga});

  @override
  State<adaptercart> createState() => _adaptercartState();
}

class _adaptercartState extends State<adaptercart> {
  int TotalHarga(){
    int Totals = int.parse(widget.price)*int.parse(widget.items);
    return Totals;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                color: Colors.grey,
                offset: Offset(0,1),
                spreadRadius: 2
            )
          ]
      ),
      child: Padding(padding: EdgeInsets.only(top: 0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.all(10),
                height: 40,
                width: 40,
                color: Colors.white,
                child: Image.network(
                  "http://10.1.3.193/kopilancong/img/product/"+widget.img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.nama,
                  style: TextStyle(
                      fontSize: 10,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor
                  ),
                ),
                Text(
                  "Rp "+MoneyFormat(double.parse(widget.price))+" X "+MoneyFormat(double.parse(widget.items)),
                  style: TextStyle(
                      fontSize: 10,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor
                  ),
                ),
                Text(
                  "Rp "+MoneyFormat(double.parse(TotalHarga().toString())),
                  style: TextStyle(
                      fontSize: 10,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor
                  ),
                ),
              ],
            )
          ],
        ),),
    );
  }
}
