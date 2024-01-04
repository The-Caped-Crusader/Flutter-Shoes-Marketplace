import 'package:app_project/views/auth.dart';
import 'package:app_project/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:app_project/sqflite/database_helper.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: first_page(),
    );
  }
}

class first_page extends StatelessWidget {
  first_page();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return second_page();
      }));
    });
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: Center(
            child:
                Icon(Icons.storefront_outlined, size: 200, color: Colors.white),
          )),
    );
  }
}

class second_page extends StatefulWidget {
  const second_page({super.key});

  @override
  State<second_page> createState() => _second_pageState();
}

class _second_pageState extends State<second_page> {
  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
                child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                "images/shoes_image.jpg",
                fit: BoxFit.cover,
              ),
            )),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    width: 10,
                    height: 30,
                  ),
                  Text(
                    "The Shoe Spot",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "For shoes Products. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Container(
                    width: 10,
                    height: 30,
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: ((context) {
                        return AuthScreen();
                      })));
                    },
                    color: Colors.blue,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.only(
                        top: 25, bottom: 25, left: 100, right: 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(50)),
                      child: MaterialButton(
                        onPressed: () async {
                         List? res = await db.checkuser();
                          
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return signupScreen(check: res,);
                          })));
                        },
                        highlightColor: Colors.blue,
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.only(
                            top: 25, bottom: 25, left: 100, right: 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
