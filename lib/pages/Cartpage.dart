

import 'package:app_project/components/color.dart';
import "package:app_project/components/button.dart";
import "package:app_project/components/color.dart";
import "package:app_project/pages/Homepage.dart";
import "package:app_project/sqflite/database_helper.dart";

import "package:flutter/material.dart";
import "package:app_project/Widgets/CartAppBar.dart";

import "package:app_project/constant/const.dart";

class CartPage extends StatefulWidget {
  List? cart;
  final String username;
  num? sum;
  CartPage({Key? mykey, required this.username, this.cart, this.sum})
      : super(key: mykey);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final db = DatabaseHelper();
    widget.sum = 0;
    for (int i = 0; i < widget.cart!.length; i++) {
      widget.sum = widget.sum! +
          (widget.cart![i]['amount'] * widget.cart![i]['productprice']);
    }
    return Scaffold(
        appBar: AppBar(
          title: CartAppBar(),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                // height: 700,
                padding: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  color: Color(mainColor),
                ),
                child: Column(children: [
                  Container(
                    height: 450,
                    child: ListView.builder(
                      itemCount: widget.cart!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Container(
                              height: 110,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 11, vertical: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    margin: EdgeInsets.only(right: 15),
                                    child: Center(
                                        child: Image.asset(
                                      "${widget.cart![i]['productpicture']}",
                                      width: 100,
                                      height: 100,
                                    )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${widget.cart![i]['usrproduct']}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF4C53A5))),
                                        Text(
                                          "${widget.cart![i]['productprice']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4C53A5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("quantity",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF4C53A5))),
                                        Text(
                                          "${widget.cart![i]['amount']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF4C53A5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                        child: IconButton(
                                            onPressed: () async {
                                              var res = await db.delete(widget
                                                  .cart![i]['productpicture']);

                                              List? updatedCart = await db
                                                  .getcart(widget.username);

                                              setState(() {
                                                widget.cart = updatedCart;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 35,
                                            ))),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(mainColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage(
                                                usrName: widget.username,
                                              )));
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 35,
                                )),
                          ),
                        ],
                      )),
                ]),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 150,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Total:",
                            style: TextStyle(
                              color: Color(mainColor),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "\$ ${widget.sum}",
                            style: TextStyle(
                              color: Color(mainColor),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  button(
                    color: primaryColor,
                    label: "Confirm purchase",
                    press: () async {
                      var check = await db.checkcart(widget.username);
                      if (check!) {
                        var res =
                            await db.deleteall(widget.cart![0]["usr_Name"]);
 List? updatedCart = await db
                                                  .getcart(widget.username);

                                              setState(() {
                                                widget.cart = updatedCart;
                                              });
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setModalState) {
                                return Container(
                                  
                                    height: 320,
                                    color: Color(0xffceddee),
                                    child: SingleChildScrollView(
                                      controller: ScrollController(
                                          keepScrollOffset: false),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10, right: 10, bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Color(0xff475269),
                                                          blurRadius: 5,
                                                          spreadRadius: 1,
                                                        ),
                                                      ]),
                                                  child: IconButton(
                                                    icon: Icon(Icons.close),
                                                    color: Colors.black,
                                                    onPressed: () {
                                                      setModalState(() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            StatefulBuilder(builder:
                                                (context, setModalState) {
                                              return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(top: 10),
                                                      height: 250,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            15),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                height: 140,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xfff5f9fd),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                          color: Color(0xff475269).withOpacity(
                                                                              0.3),
                                                                          blurRadius:
                                                                              5,
                                                                          spreadRadius:
                                                                              1)
                                                                    ]),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          290,
                                                                      height:
                                                                          100,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            mainColor),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            "Purchase is sucess",
                                                                            style: TextStyle(
                                                                                fontSize: 25,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white),
                                                                          ),
                                                                          Icon(
                                                                            Icons.check,
                                                                            size:
                                                                                40,
                                                                            color:
                                                                                Colors.green,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    )
                                                  ]);
                                            }),
                                          ],
                                        ),
                                      ),
                                    ));
                              });
                            });
                      }
                    },
                    style1: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    h: 55,
                  )
                ]),
          ),
        ));
  }
}
