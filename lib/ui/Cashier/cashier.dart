import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Adapter/adaptercashier.dart';
import 'dart:convert';
import 'package:kopi_lancong_latihan/Adapter/cashieradapter.dart';
import 'package:kopi_lancong_latihan/Color/colors.dart' as NewColor;
import 'package:kopi_lancong_latihan/Model/Ascendant.dart';
import 'package:http/http.dart' as http;
import '../../API/server.dart';

class cashier extends StatefulWidget {
  const cashier({Key? key}) : super(key: key);

  @override
  State<cashier> createState() => _cashierState();
}

class _cashierState extends State<cashier> {
  String Items = "0";
  String TotalHarga = "0";

  Future<List> getData() async{
    final response=await http.get(Uri.parse(getServerName()+'api/product/all'));
    return json.decode(response.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 3.0,
          backgroundColor: Theme.of(context).primaryColor,
          leading: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.brown
                  ),
                  onPressed: () => ToHome(context),
                ),
              ),
            ),
          ),
          title: Text(
              "Cashier",style: TextStyle(
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
          Stack(
            children: <Widget>[
              Container(
                child: new FutureBuilder<List>(
                  future: getData(),
                  builder: (context,snapshot){
                    if(snapshot.hasError) print(snapshot.error);
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.requireData==null ? 0 : snapshot.requireData.length,
                          itemBuilder: (context,i){
                              return adaptercashier(
                                img: snapshot.requireData[i]['img_product'],
                                nama: snapshot.requireData[i]['nama_product'],
                                price: snapshot.requireData[i]['price'],
                              );
                          });
                    } else{
                      return new Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: NewColor.PrimaryColors(),
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                              Items,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            )
                        ),
                        Expanded(
                            child: Text(
                              TotalHarga,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.right,
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
