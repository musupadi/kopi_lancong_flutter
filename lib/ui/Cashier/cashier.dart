import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Adapter/adaptercashier.dart';
import 'dart:convert';
import 'package:kopi_lancong_latihan/Adapter/cashieradapter.dart';
import 'package:kopi_lancong_latihan/Color/colors.dart' as NewColor;
import 'package:kopi_lancong_latihan/Model/Ascendant.dart';
import 'package:http/http.dart' as http;
import 'package:kopi_lancong_latihan/Model/Cashier.dart';
import 'package:kopi_lancong_latihan/SharedPreference/db_helper.dart';
import '../../API/server.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../homepage.dart';


class cashier extends StatefulWidget {
  const cashier({Key? key}) : super(key: key);

  @override
  State<cashier> createState() => _cashierState();
}

class _cashierState extends State<cashier> {
  String Items = "0";
  String TotalHarga = "0";
  late List<Cashier> ListCashier;
  late List<String> ID;
  late List<String> Quantity;
  late Map<String,String>data;

  @override
  void initState() {
    // Get.to(logins);

    db_helper.instance.deleteAll();
    super.initState();
  }

  Future<List> getData() async{
    final response=await http.get(Uri.parse(getServerName()+'api/product/all'));
    return json.decode(response.body)['data'];
  }
  Future Logic() async {

    int timeout = 5;
    ListCashier = await db_helper.instance.readAll();
    int Length = ListCashier.length;

    data={
      "nominal_keuangan": "1000",
      "id_user": "00000"
    };

    for(int i=0;i <Length;i++){
      data.addAll({"quantity[$i]": ListCashier[i].jumlah.toString()});
    }
    for(int i=0;i <Length;i++){
      data.addAll({"id_product[$i]": ListCashier[i].id_product.toString()});
    }

    try{
      final response = await http.post(
          Uri.parse(getServerName()+"api/cashier/payment"),
          body: data).timeout(Duration(seconds: timeout));
      if(response.reasonPhrase == 'OK'){
        AwesomeDialog(
            context: context,
            dismissOnTouchOutside: true,
            dismissOnBackKeyPress: false,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: "Test",
            desc: "Response "+jsonDecode(response.body)['message'].toString(),
            btnOkOnPress: () {
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
                        return homepage();
                      }
                  )
              );
            },
            headerAnimationLoop: false
        )..show();
      }else{
        print(response.reasonPhrase);
      }
    } on TimeoutException catch (e){
      // setState(() => isLoading=false);
      FailedMessage("Login Failed", "Koneksi Gagal",context);
    } on SocketException catch (e){
      // setState(() => isLoadingg=false);
      FailedMessage("Login Failed", "Socket Salah",context);
    } on Error catch (e){
      FailedMessage("Loginn Failed", "Error karena : "+e.toString(),context);
    }

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
                                id: snapshot.requireData[i]['id_product'],
                              );
                          });
                    } else{
                      return new Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: Logic,
                child: Align(
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
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
