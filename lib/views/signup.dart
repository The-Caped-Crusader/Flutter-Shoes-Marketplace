import 'package:app_project/JSON/users.dart';
import 'package:app_project/components/button.dart';
import 'package:app_project/components/textfield.dart';
import 'package:app_project/sqflite/database_helper.dart';
import 'package:app_project/views/auth.dart';
import 'package:flutter/material.dart';

class signupScreen extends StatefulWidget {
  final List? check;
  const signupScreen({super.key, this.check});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final confirmPassword = TextEditingController();
  final usrName = TextEditingController();
  final password = TextEditingController();
  final db = DatabaseHelper();
  final formkey = GlobalKey<FormState>();

  signUp() async {
    var res = await db.createUser(Users(
        fullName: fullName.text,
        email: email.text,
        usrName: usrName.text,
        password: password.text));
    if (res > 0) {
      if (!mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AuthScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Sign up page",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      )),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Form(
                    key: formkey,
                    child: Column(children: [
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
                      InputField(
                        valu: (value) {
                          if (value!.isEmpty) {
                            return "Fullname is required";
                          }
                          return null;
                        },
                        hint: "Fullname",
                        icon: Icons.person,
                        controller: fullName,
                        horizon: 10,
                      ),
                      InputField(
                        valu: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          } else if (!value.endsWith('@yahoo.com') &&
                              !value.endsWith('@gmail.com')) {
                            return "Email is incorrect";
                          }
                          for (int i = 0; i < widget.check!.length; i++) {
                            if (widget.check![i]["email"]==value) {
                              return "Email already exist";
                            }
                          }

                          return null;
                        },
                        hint: "Email",
                        icon: Icons.email,
                        controller: email,
                        horizon: 10,
                      ),
                      InputField(
                        valu: (value) {
                          print("res ${widget.check}");

                          if (value!.isEmpty) {
                            return "Username is required";
                          }
                          for (int i = 0; i < widget.check!.length; i++) {
                            if (widget.check![i]["usrName"] == value) {
                              return "Username already exist";
                            }
                          }
                          return null;
                        },
                        hint: "Username",
                        icon: Icons.account_circle,
                        controller: usrName,
                        horizon: 10,
                      ),
                      InputField(
                        valu: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                        hint: "Password",
                        icon: Icons.lock,
                        controller: password,
                        horizon: 10,
                        passwordinvisible: true,
                      ),
                      InputField(
                        valu: (value) {
                          if (value!.isEmpty) {
                            return "confim password is required";
                          } else if (password.text != confirmPassword.text) {
                            return "password dont match";
                          }
                          return null;
                        },
                        hint: "Confirm password",
                        icon: Icons.lock,
                        controller: confirmPassword,
                        horizon: 10,
                        passwordinvisible: true,
                      ),
                      button(
                        label: "Sign up",
                        style1: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        press: () async {
                          if (formkey.currentState!.validate()) {
                            signUp();
                          }
                        },
                        h: 55, color: Colors.blue,
                      )
                    ])))
          ],
        )),
      ),
    );
  }
}
