import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Adapter/adaptercart.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import '../../homepage.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class cashier extends StatefulWidget {
  const cashier({Key? key}) : super(key: key);

  @override
  State<cashier> createState() => _cashierState();
}

class _cashierState extends State<cashier> {
  //Session
  String IDS="";


  String Items = "0";
  String TotalHarga = "0";
  int Total = 0;
  late List<Cashier> ListCashier;
  late List<String> ID;
  late List<String> Quantity;
  late Map<String,String>data;
  TextEditingController controllerTotal = MoneyMaskedTextController(decimalSeparator: '',thousandSeparator: '.',precision: 0,leftSymbol: "Rp ");
  TextEditingController controllerBayar = MoneyMaskedTextController(decimalSeparator: '',thousandSeparator: '.',precision: 0,leftSymbol: "Rp ");
  TextEditingController controllerKembalian = MoneyMaskedTextController(decimalSeparator: '',thousandSeparator: '.',precision: 0,leftSymbol: "Rp ");
  @override
  void initState() {
    // Get.to(logins);

    db_helper.instance.deleteAll();
    super.initState();
    Sessions();
  }
  Widget BottomPerhitungan(String Items,String TotalHarga){
    return GestureDetector(
      onTap: () => Pembayaran(),
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: NewColor.PrimaryColors(),
              borderRadius: BorderRadius.circular(40)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Bayar",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
  Future<List> getDataCart() async{
    ListCashier = await db_helper.instance.readAll();
    return ListCashier;
  }
  Future<List> getData() async{
    final response=await http.get(Uri.parse(getServerName()+'api/product/all'));
    return json.decode(response.body)['data'];
  }
  Future<void> Sessions() async{
    final prefs = await SharedPreferences.getInstance();
    final String? id = await prefs.getString('id');

    setState(() => IDS = id.toString());

  }
  Future Pembayaran() async{
    ListCashier = await db_helper.instance.readAll();
    int Length = ListCashier.length;
    int kem = 0;
    if(Length>0){
      for(int i=0;i <Length;i++){
        Total=Total+ListCashier[i].harga.toInt();
      }
      controllerTotal.text = Total.toString();
      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.question,
          animType: AnimType.topSlide,
          btnOkText: "Bayar",
          title: "Pembayaran",
          desc: "Jumlah Yang Harus Dibayarkan : "+Total.toString(),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10,right: 10,left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: NewColor.PrimaryColors()
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Daftar yang ingin di beli",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15),),
                ),
              ),
              Container(
                height: 350,
                child: ListView.builder(
                  itemCount: Length,
                  itemBuilder: (context,i){
                    return adaptercart(
                        img: ListCashier[i].gambar,
                        nama: ListCashier[i].nama,
                        price: ListCashier[i].harga.toString(),
                        id: ListCashier[i].id_product.toString(),
                        items: ListCashier[i].jumlah.toString(),
                        totalharga : TotalHarga);
                  },
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  child: TextField(
                    readOnly: true,
                    controller: controllerTotal,
                    decoration: InputDecoration(
                      hintText: 'Rp ',
                      prefixIcon: Icon(Icons.money),
                      labelText: 'Total',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  )
              ),
              Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  child: TextField(
                    controller: controllerBayar,
                    onChanged: (text) {
                      kem = int.parse(CalculateCurrency(controllerBayar.text))-int.parse(CalculateCurrency(controllerTotal.text));
                      if(kem>=0){
                        controllerKembalian.text = kem.toString();
                      }else{
                        controllerKembalian.text = "Pembayaran Kurang";
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Rp ',
                        prefixIcon: Icon(Icons.money),
                        labelText: 'Pembayaran',
                        border: OutlineInputBorder(),
                        suffixIcon: controllerBayar.text.isEmpty ? Container(width: 0,): IconButton(
                          icon: Icon(
                              Icons.close,
                              color: Colors.red),
                          onPressed: ()=> controllerBayar.clear(),
                        )
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  )
              ),
              Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  child: TextField(
                    readOnly: true,
                    controller: controllerKembalian,
                    decoration: InputDecoration(
                      hintText: 'Rp ',
                      prefixIcon: Icon(Icons.money),
                      labelText: 'Kembalian',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  )
              ),
            ],
          ),
          btnOkOnPress: () {
            // print(CalculateCurrency(controllerBayar.text));
            if(int.parse(CalculateCurrency(controllerBayar.text))>=int.parse(CalculateCurrency(controllerTotal.text))){
              Logic(kem.toString());
            }else{
              AwesomeDialog(
                  context: context,
                  dismissOnTouchOutside: true,
                  dismissOnBackKeyPress: false,
                  dialogType: DialogType.warning,
                  animType: AnimType.scale,
                  title: "Pembayaran Kurang",
                  desc: "Mohon Periksa lagi Pembayaran yang Kurang",
                  btnOkOnPress: () {

                  },
                  headerAnimationLoop: false
              )..show();
            }
            // if(int.parse(controllerTotal.text)>=int.parse(controllerBayar.text)){
            //
            // }else{
            //   print("Gagal");
            // }
          },
          btnCancelOnPress: (){

          },
          headerAnimationLoop: false
      ).show();
    }else{
      AwesomeDialog(
          context: context,
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.warning,
          animType: AnimType.bottomSlide,
          title: "Mohon isi item Belanja terlebih dahulu",
          desc: "Harap Isi List Belanja Terlebih dahulu",
          btnOkOnPress: () {

          },
          headerAnimationLoop: false
      )..show();
    }

  }
  Future Logic(String Kembalian) async {
    int timeout = 5;
    ListCashier = await db_helper.instance.readAll();
    int Length = ListCashier.length;
    for(int i=0;i <Length;i++){
      Total=Total+ListCashier[i].harga.toInt();
    }
    data={
      "nominal_keuangan": Total.toString(),
      "id_user": IDS
    };
    // print("ID : "+IDS);
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
            title: "Pembayaran Berhasil",
            desc: Kembalian=="0" ? jsonDecode(response.body)['message'].toString(): jsonDecode(response.body)['message'].toString()+"\nKembalian Anda : "+Kembalian,
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
    return WillPopScope(

      onWillPop: () async{
        ToHome(context);
        return false;
      },
      child: Scaffold(
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
                                  items: Items,
                                  totalharga: TotalHarga,
                                );
                            });
                      } else{
                        return new Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                BottomPerhitungan(Items,TotalHarga)
              ],
            )
          ],
        )
      ),
    );
  }
}
