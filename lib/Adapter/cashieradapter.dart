import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Color/colors.dart' as NewColor;


class cashieradapter extends StatefulWidget {
  final List list;
  final String items;
  final String total;
  const cashieradapter({Key? key,required this.list,required this.items,required this.total}) : super(key: key);

  @override
  State<cashieradapter> createState() => _cashieradapterState();
}

class _cashieradapterState extends State<cashieradapter> {
  int Tambah = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list==null ? 0 : widget.list.length,
        itemBuilder: (context,i){
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
                        "http://10.1.3.193/kopilancong/img/product/"+widget.list[i]['img_product'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.list[i]['nama_product'],
                        style: TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor
                        ),
                      ),
                      Text(
                        widget.list[i]['price'],
                        style: TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor
                        ),
                      ),
                      Divider(thickness: 2,),
                      GestureDetector(
                        onTap: () => setState(() => Tambah=Tambah+1),
                        child: Container(
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
                        )
                      )
                    ],
                  )
                ],
              ),),
          );
        }
    );
  }
}