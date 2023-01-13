import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Color/colors.dart' as NewColor;
import 'package:kopi_lancong_latihan/Model/Cashier.dart';
import 'package:kopi_lancong_latihan/SharedPreference/db_helper.dart';
import 'package:kopi_lancong_latihan/ui/Cashier/cashier.dart';
class adaptercashier extends StatefulWidget {
  String id;
  String img;
  String nama;
  String price;
  String items;
  String totalharga;
  adaptercashier({Key? key,required this.img,required this.nama,required this.price,required this.id,required this.items,required this.totalharga});

  @override
  State<adaptercashier> createState() => _adaptercashierState();

}

Widget Ada(int Tambah){
  return Container(
    width: 200,
    decoration: BoxDecoration(
        border: Border.all(color: NewColor.PrimaryColors()),
        borderRadius: BorderRadius.circular(30)
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: NewColor.PrimaryColors(),
                borderRadius: BorderRadius.circular(100)
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              Tambah.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: NewColor.PrimaryColors(),
                  fontFamily: 'gotham'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: NewColor.PrimaryColors(),
                    borderRadius: BorderRadius.circular(100)
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
Widget Kosong(){
  return Container(
    width: 200,
    decoration: BoxDecoration(
        color: NewColor.PrimaryColors(),
        borderRadius: BorderRadius.circular(30)
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        "Tambah",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'gotham'
        ),
      ),
    ),
  );
}


class _adaptercashierState extends State<adaptercashier> {
  int Tambah = 0;
  late Cashier cashiers;
  void Plus(){
    Tambah=Tambah+1;
    int TotH = int.parse(widget.totalharga)+int.parse(widget.price);

    cashier(key: UniqueKey(),);
    if(Tambah<=1){
      cashiers = new Cashier(id_product: int.parse(widget.id),nama: widget.nama, jumlah: Tambah, harga: int.parse(widget.price),gambar: widget.img);
      db_helper.instance.create(cashiers);
    }else{
      cashiers = new Cashier(id_product: int.parse(widget.id),id: int.parse(widget.id),nama: widget.nama, jumlah: Tambah, harga: int.parse(widget.price),gambar: widget.img);
      db_helper.instance.update(cashiers);
    }
  }
  void Minus(){
    Tambah=Tambah-1;
    if(Tambah>0){
      print(widget.id+" : "+"Updated");
      cashiers = new Cashier(id_product: int.parse(widget.id),nama: widget.nama, jumlah: Tambah, harga: int.parse(widget.price),gambar: widget.img);
      db_helper.instance.create(cashiers);
    }else{
      print(widget.id+" : "+"Deleted");
      // cashiers = new Cashier(id_product: int.parse(widget.id),nama: widget.nama, jumlah: Tambah, harga: int.parse(widget.price),gambar: widget.img);
      db_helper.instance.delete(int.parse(widget.id));
    }
  }
  @override
  void initState() {
    // Get.to(logins);
    super.initState();
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
                blurRadius: 7,
                color: Colors.grey,
                offset: Offset(0,3),
                spreadRadius: 4
            )
          ]
      ),
      child: Padding(padding: EdgeInsets.only(top: 0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.all(20),
                height: 80,
                width: 80,
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
                      fontSize: 16,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor
                  ),
                ),
                Text(
                  widget.price,
                  style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor
                  ),
                ),
                Divider(thickness: 2,),
                Tambah <1 ? GestureDetector(
                    child: Kosong(),
                    onTap: () => setState(() => Plus())
                ):
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: NewColor.PrimaryColors()),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => Minus()),
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                color: NewColor.PrimaryColors(),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Icon(Icons.arrow_left,color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            Tambah.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: NewColor.PrimaryColors(),
                                fontFamily: 'gotham'),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => Plus()),
                          child: Container(
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                  color: NewColor.PrimaryColors(),
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Icon(Icons.arrow_right,color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),),
    );
  }
}
