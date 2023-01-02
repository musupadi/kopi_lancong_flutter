import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Color/colors.dart' as NewColor;
import 'package:kopi_lancong_latihan/Model/Ascendant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Cashier/cashier.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String Nama="Nama";

  @override
  void initState() {
    // Get.to(logins);
    super.initState();
    NamaSession();
  }

  Future<void> NamaSession() async{
    final prefs = await SharedPreferences.getInstance();
    final String? name = await prefs.getString('name');

    setState(() => Nama = name.toString());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 3.0,
          backgroundColor: NewColor.PrimaryColors(),
          title: Text(
            "Home",style: TextStyle(
              fontSize: 25,
              color: Colors.white
           ),
          ),
          actions : [
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 28,
              ),
            )
          ]
      ),
        body: Stack(
        children: <Widget>[
            Container(
              color: NewColor.PrimaryColors(),
              height: 164,
              width: double.infinity,
            ),
            Column(children: [
              SizedBox(
                width: double.infinity,
                height: 25,),
              Container(
                margin: EdgeInsets.all(10),
                height: 227,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      color: Colors.grey,
                      offset:Offset(0,3),
                      spreadRadius: 4
                    )
                  ]
                ),
                child:  Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: CircleAvatar(
                                backgroundColor: NewColor.PrimaryColors(),
                                foregroundImage: AssetImage("assets/img/musupadi.jpg"),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text(Nama,
                                    style: TextStyle(
                                        color: NewColor.PrimaryColors(),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                              ),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text("Developer",style: TextStyle(
                                      color: NewColor.PrimaryColors(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),)
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(thickness: 2,),
                      Row(
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: 70,
                              width: 70,
                              child: CircleAvatar(
                                backgroundColor: NewColor.SecondaryColors(),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset("assets/img/wallet.png"),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text("Profit Today",style: TextStyle(
                                        color: NewColor.PrimaryColors(),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),)
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.all(10),
                                  child: Text("Rp.0",style: TextStyle(
                                      color: NewColor.PrimaryColors(),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                ),
              SizedBox(width: double.infinity, height: 25),
              Container(
                height: 150,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => ToCashier(context),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Container(
                              height: 65,
                              width: 65,
                              child: CircleAvatar(
                                backgroundColor: NewColor.SecondaryColors(),
                                foregroundImage: AssetImage("assets/img/cashier.png"),
                                maxRadius: 60,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("Cashier",
                            style: TextStyle(
                              color: NewColor.PrimaryColors(),
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 65,
                            width: 65,
                            child: CircleAvatar(
                              backgroundColor: NewColor.SecondaryColors(),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset("assets/img/finance.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Finance",style: TextStyle(
                            color: NewColor.PrimaryColors(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 65,
                            width: 65,
                            child: CircleAvatar(
                              backgroundColor: NewColor.SecondaryColors(),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset("assets/img/product.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Product",style: TextStyle(
                            color: NewColor.PrimaryColors(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 65,
                            width: 65,
                            child: CircleAvatar(
                              backgroundColor: NewColor.SecondaryColors(),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset("assets/img/inventory.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Inventory",style: TextStyle(
                            color: NewColor.PrimaryColors(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 65,
                            width: 65,
                            child: CircleAvatar(
                              backgroundColor: NewColor.SecondaryColors(),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset("assets/img/employee.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Employee",style: TextStyle(
                            color: NewColor.PrimaryColors(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            height: 65,
                            width: 65,
                            child: CircleAvatar(
                              backgroundColor: NewColor.SecondaryColors(),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Image.asset("assets/img/product.png"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Product",style: TextStyle(
                            color: NewColor.PrimaryColors(),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ],
                ),
              )
              ],
            )
        ],
      )
    );
  }
}
