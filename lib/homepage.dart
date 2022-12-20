import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:kopi_lancong_latihan/Model/Ascendant.dart';
import 'package:kopi_lancong_latihan/ui/profile.dart';
import 'Color/colors.dart' as NewColor;
import 'ui/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _currentIndex = 0;
  String id="0";
  String name="";
  String username="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id")!;
      username = pref.getString("username")!;
      name = pref.getString("name")!;
    });
  }
  void _navigationBottomBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  final List<Widget>tabs = [
    home(),
    profile(),
    Text("data3"),
  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return LogoutMessage("Logout", "Yakin Ingin Logout ?", context);
      },
      child: Scaffold(
            body: tabs[_currentIndex],
            bottomNavigationBar: ConvexAppBar.badge(
              const <int,dynamic>{3:'99+'},
              style: TabStyle.custom,
              backgroundColor: NewColor.PrimaryColors(),
              items: <TabItem>[
                TabItem(icon: Icons.home,title: "Home"),
                TabItem(icon: Icons.person,title: "Profile"),
                TabItem(icon: Icons.settings,title: "Setting")
              ],
              onTap: (int i) => _navigationBottomBar(i),
            )
      ),
    );
  }
}
