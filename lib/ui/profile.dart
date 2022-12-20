import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/Color/colors.dart' as NewColor;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../Model/Ascendant.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewColor.SecondaryColors(),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 3.0,
          backgroundColor: NewColor.PrimaryColors(),
          title: Text(
            "Profile",style: TextStyle(
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
            child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStatePropertyAll(10),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: (){
                  LogoutMessage("Logout", "Yakin Ingin Logout ?", context);
                },
                child: Text("Logout")),
          )
        ],
      ),

    );
  }
}

