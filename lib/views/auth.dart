import 'package:app_project/JSON/users.dart';
import 'package:app_project/components/button.dart';

import 'package:app_project/components/textfield.dart';
import 'package:app_project/main.dart';

import 'package:app_project/sqflite/database_helper.dart';
import 'package:app_project/views/signup.dart';
import 'package:flutter/material.dart';
import "package:app_project/profile.dart";
import "package:app_project/pages/Homepage.dart";

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final usrName = TextEditingController();
  final password = TextEditingController();
  bool ischecked = false;
  bool islogintrue = false;
  final db = DatabaseHelper();
  final formkey = GlobalKey<FormState>();

  login() async {
    Users? usrDetails = await db.getUser(usrName.text);
    
    var res = await db
        .authenticate(Users(usrName: usrName.text, password: password.text));
    if (res == true) {
      if (!mounted) return;
      Profile(profile: usrDetails);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage(usrName: usrName.text)));
        
    } else {
      setState(() {
        islogintrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         automaticallyImplyLeading: false,
          title: Container(
            padding: EdgeInsets.symmetric(vertical:25),
            child: Row(
              children: [
                 IconButton(padding: EdgeInsets.only(right: 30),onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const second_page())));
                  }, icon:Icon(Icons.arrow_back,size: 25,) ),
                
                Text(
                  "Login page",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
            child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: SizedBox(
                  
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          alignment: Alignment.center,
                          width: 180,
                          height: 180,
                          color: Colors.blue,
                          child: Icon(Icons.storefront_outlined,
                              size: 130, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      const Text(
                        "The Shoe Spot",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 60,
                      ),
                      InputField(
                          valu: (value) {
                            if (value!.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                          hint: "Username",
                          icon: Icons.account_circle,
                          controller: usrName,
                          horizon: 15),
                      InputField(
                          valu: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          hint: "password",
                          icon: Icons.lock,
                          controller: password,
                          passwordinvisible: true,
                          horizon: 15),
                      Expanded(child: Container()),
                      button(
                          label: "LOGIN",
                          style1: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          press: () {
                            if (formkey.currentState!.validate()) {
                              login();
                            }
                          },h: 55,
                          color: Colors.blue,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const signupScreen())));
                              },
                              child: const Text("Sign up"))
                        ],
                      ),
                      islogintrue
                          ? const Text("Username or password are in correct",
                              style: TextStyle(color: Colors.red))
                          : const SizedBox(),
                    ],
                  ),
                ),
              )),
        )));
  }
}
