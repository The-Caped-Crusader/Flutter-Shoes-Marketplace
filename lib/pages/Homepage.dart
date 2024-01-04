
import 'package:app_project/pages/Cartpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app_project/sqflite/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_project/JSON/users.dart';
import 'package:flutter/material.dart';
import 'package:app_project/Widgets/HomeAppBar.dart';
import 'package:app_project/profile.dart';
import 'package:app_project/views/auth.dart';
import '/../Widgets/ItemsWidget.dart';
import '/../constant/const.dart';

class HomePage extends StatefulWidget {
  final String usrName;
  final Users? userId;
  HomePage({Key? mykey, required this.usrName, this.userId})
      : super(key: mykey);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selected_index = 0;
  final db = DatabaseHelper();

  return_to_profile() async {
    Users? usrDetails = await db.getUser(widget.usrName);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Profile(profile: usrDetails)));
  }

  go_to_cart() async {
    List? usrDetails = await db.getcart(widget.usrName);
    
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CartPage(username: widget.usrName,cart: usrDetails,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HomeAppBar(),
        backgroundColor: Color(mainColor),
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          Container(
            height: 20,
          ),
          ListTile(
            splashColor: Color(mainColor),
            title: Container(
              height: 50,
              child: Row(
                children: [
                  Icon(Icons.card_travel),
                  Container(
                    width: 20,
                  ),
                  Text(
                    "Cart",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            onTap: () {
              go_to_cart();
            },
          ),
          Container(
            height: 20,
          ),
          ListTile(
            title: Container(
              height: 50,
              child: Row(
                children: [
                  Icon(Icons.logout),
                  Container(
                    width: 20,
                  ),
                  const Text(
                    "Log out",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const AuthScreen())));
            },
          ),
        ],
      )),
      body: ListView(children: [
        Container(
          // height:500,
          padding: EdgeInsets.only(top: 15, bottom: 30),
          decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              )),
          child: Column(children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text("Products",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(mainColor),
                  )),
            ),
            ItemsWidget(
              usrName: widget.usrName,
            ),
          ]),
        ),
      ]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 70,
        index: _selected_index,
        color: Color(mainColor),
        items: [
          Container(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      _selected_index = 0;
                    });
                  },
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.white,
                  ))),
          Container(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      return_to_profile();
                    });
                  },
                  icon: Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }
}
