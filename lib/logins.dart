import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kopi_lancong_latihan/API/server.dart';
import 'package:kopi_lancong_latihan/homepage.dart';
import 'Color/colors.dart' as NewColor;
import 'package:http/http.dart' as http;
import 'API/server.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Model/Ascendant.dart';
import 'Model/SessionHelper.dart';


class logins extends StatefulWidget {
  const logins({Key? key}) : super(key: key);

  @override
  State<logins> createState() => _loginsState();
}


class _loginsState extends State<logins> {
  bool passenable = true; //boolean value to track password view enable disable.
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  bool isLoading = false;
  LoginSuccess (String name){
    AwesomeDialog(
        context: context,
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "Login Succes",
        desc: "Selamat Datang "+name,
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
  }
  Logins() async{
    int timeout = 5;
    setState(() => isLoading=true);
    // LoadingMessage("Mencoba Login", "Sedang Mencoba Login", context);
    try{
      final response = await http.post(
          Uri.parse(getServerName()+Login()),body: {
        "username": controllerUsername.text,
        "password": controllerPassword.text
      }).timeout(Duration(seconds: timeout));
      if(response.reasonPhrase == 'OK'){
        setState(() => isLoading=false);
        print(controllerUsername);
        print(controllerPassword);
        if(jsonDecode(response.body)['code'] == 0){
          // Obtain shared preferences.
          final prefs = await SharedPreferences.getInstance();

          await prefs.setString('id', jsonDecode(response.body)['data'][0]['id'].toString());
          await prefs.setString('username', jsonDecode(response.body)['data'][0]['username'].toString());
          await prefs.setString('name', jsonDecode(response.body)['data'][0]['nama'].toString());
          //
          //
          String? name = prefs.getString('name');
          // var sessionManager = SessionManager();
          // await sessionManager.set("id", jsonDecode(response.body)['data'][0]['id'].toString());
          // await sessionManager.set("username", jsonDecode(response.body)['data'][0]['username'].toString());
          // await sessionManager.set("name", jsonDecode(response.body)['data'][0]['nama'].toString());

          // String name = await SessionManager().get("name").toString();
          LoginSuccess(name.toString());

        }else{
          setState(() => isLoading=false);
          FailedMessage("Login Failed", "Username atau Password Salah",context);
        }
        return jsonDecode(response.body)['data'][0]['nama'].toString();
      }else{
        FailedMessage("Login Failed", "Terjadi Kesalahan",context);
        print(response.reasonPhrase);
      }
    } on TimeoutException catch (e){
      setState(() => isLoading=false);
      FailedMessage("Login Failed", "Koneksi Gagal",context);
    } on SocketException catch (e){
      setState(() => isLoading=false);
      FailedMessage("Login Failed", "Socket Salah",context);
    } on Error catch (e){
      setState(() => isLoading=false);
      // FailedMessage("Login Failed", "Error karena : "+e.toString(),context);
    }

  }
  @override
  void initState() {
    // Get.to(logins);
    super.initState();
    controllerUsername.addListener(() => setState((){}));
  }



  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              color: NewColor.SecondaryColors(),
            ),
            Container(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Image.asset("assets/img/kopi_lancong.png")
                      ),
                      Container(
                        color: NewColor.PrimaryColors(),
                        height: 50,
                        width: double.infinity,
                        child: Center(child: new Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.grey,
                                  offset: Offset(0,2),
                                  spreadRadius: 2
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: SingleChildScrollView(
                              child: new Column(
                                children: <Widget>[
                                  Container(
                                    child: TextField(
                                      controller: controllerUsername,
                                      decoration: InputDecoration(
                                          hintText: 'contoh@gmail.com',
                                          prefixIcon: Icon(Icons.mail),
                                          labelText: 'Username',
                                          border: OutlineInputBorder(),
                                          suffixIcon: controllerUsername.text.isEmpty ? Container(width: 0,): IconButton(
                                            icon: Icon(
                                                Icons.close,
                                                color: Colors.red),
                                                  onPressed: ()=> controllerUsername.clear(),
                                          )
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.done,
                                    )
                                  ),
                                  SizedBox(height: 30,),
                                  Container(
                                      child: TextField(
                                        controller: controllerPassword,
                                        decoration: InputDecoration(
                                            hintText: 'Password Anda...',
                                            prefixIcon: Icon(Icons.lock),
                                            labelText: 'Password',
                                            border: OutlineInputBorder(),
                                            suffixIcon: IconButton(
                                              icon: passenable
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility),
                                              onPressed: () =>
                                              setState(() => passenable = !passenable)
                                            )
                                        ),
                                        obscureText: passenable,
                                        keyboardType: TextInputType.emailAddress,
                                        textInputAction: TextInputAction.done,
                                      )
                                  ),
                                  SizedBox(height: 30,),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        height: 50,
                                        child: ElevatedButton.icon(
                                          style: ButtonStyle(
                                            elevation: MaterialStatePropertyAll(10),
                                            backgroundColor: MaterialStateProperty.all(NewColor.PrimaryColors()),
                                          ),
                                          label: Text("Login",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                            ),
                                          ),
                                          icon: Icon(Icons.login),
                                          onPressed: () async {
                                            // Navigator.of(context).push(
                                            //   new MaterialPageRoute(builder: (BuildContext context) => homepage() )
                                            // );
                                            Logins();
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if(isLoading)
              Stack(
                  children:[
                    Container(
                        color: Colors.black.withOpacity(0.5)
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: SpinKitFoldingCube(
                              color: Colors.white,
                              size: 50,
                            )
                        ),
                        SizedBox(width: double.infinity, height: 20,),
                        Text("Sedang Mencoba Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                        )
                      ],
                    )
                  ]
              ),
          ],
        ),
      ),
    );
  }
}
