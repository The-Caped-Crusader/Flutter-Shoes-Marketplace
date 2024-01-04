import 'package:app_project/components/button.dart';
import 'package:app_project/components/color.dart';
import 'package:app_project/pages/Homepage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:app_project/JSON/users.dart';
import 'package:app_project/main.dart';
import 'package:app_project/Widgets/HomeAppBar.dart';
import 'package:flutter/material.dart';
import '/../constant/const.dart';

class Profile extends StatefulWidget {
  final Users? profile;
  const Profile({Key? mykey, this.profile}) : super(key: mykey);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    int _selected_index = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color(mainColor),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 45, horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 77,
              child: CircleAvatar(
                backgroundImage: AssetImage("images/profile.png"),
                backgroundColor: primaryColor,
                radius: 75,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
              ),
              subtitle: Text("Full name"),
              title: Text(widget.profile!.fullName ?? ""),
            ),
            ListTile(
              leading: Icon(
                Icons.email,
                size: 30,
              ),
              subtitle: Text("Email"),
              title: Text(widget.profile!.email ?? ""),
            ),
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 30,
              ),
              subtitle: Text("Username"),
              title: Text(widget.profile!.usrName ?? ""),
            ),
            button(
              color: primaryColor,
                label: "Sign out",
                h: 55,
                style1: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const second_page())));
                }),
          ],
        )),
      ),
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
                      Navigator.of(context)
                          .pop();
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
                      _selected_index = 1;
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
