import "package:app_project/JSON/users.dart";
import "package:app_project/sqflite/database_helper.dart";
import "package:app_project/components/button.dart";
import "package:app_project/components/color.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:app_project/constant/const.dart";

int amount = 1;
int sum = price;
int price = 0;
bool buy = false;
String? usrproduct;
int? j;
bool isincrement = false;
bool isdecrement = false;
List producttitle = [
  "blue shoes",
  "blue shoes",
  "yellow shoes",
  "black shoes",
  "Black shoes",
  "Black shoes",
  "Nike shoes"
];
List pprice = [55, 80, 90, 130, 50, 60, 70, 80];

class ItemsWidget extends StatefulWidget {
  final String usrName;
  const ItemsWidget({super.key, required this.usrName});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  final db = DatabaseHelper();

  cart() async {
    var res = await db.createcart(Users(
        usrName: widget.usrName,
        usrproduct: usrproduct,
        productprice: sum,
        productpicture: "images/$j.png",
        amount: amount));

    if (res > 0) {
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 1; i < 8; i++)
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(children: [
              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    "images/$i.png",
                    height: 100,
                    width: 120,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text("${producttitle[i - 1]}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(mainColor),
                        fontWeight: FontWeight.bold,
                      ))),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Write Description of Product",
                      style: TextStyle(fontSize: 15, color: Color(0xFF4C53A5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${pprice[i - 1]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(mainColor),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.shopping_cart_checkout),
                          color: Color(mainColor),
                          onPressed: () {
                            setState(
                              () {
                                amount = 1;

                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      usrproduct = producttitle[i - 1];
                                      j = i;
                                      price = pprice[i - 1];
                                      sum = price * amount;
                                      return StatefulBuilder(
                                          builder: (context, setModalState) {
                                        return Container(
                                            height: 300,
                                            padding: EdgeInsets.only(top: 20),
                                            color: Color(0xffceddee),
                                            child: StatefulBuilder(builder:
                                                (context, setModalState) {
                                              return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
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
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Stack(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        children: [
                                                                          Image.asset(
                                                                              "images/$i.png",
                                                                              height: 130,
                                                                              width: 130,
                                                                              fit: BoxFit.contain)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              30,
                                                                          horizontal:
                                                                              10),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "${producttitle[i - 1]}",
                                                                            style: TextStyle(
                                                                                color: Color(0xff475269),
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(left: 15),
                                                                                width: 30,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: Color(0xffff5f9fd),
                                                                                  boxShadow: [
                                                                                    BoxShadow(color: Color(0xff475269).withOpacity(0.3), blurRadius: 5, spreadRadius: 1)
                                                                                  ],
                                                                                ),
                                                                                child: IconButton(
                                                                                    icon: Icon(
                                                                                      CupertinoIcons.minus,
                                                                                      size: 10,
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      setModalState(() {
                                                                                        if (amount != 1) {
                                                                                          if (amount != 1) {
                                                                                            amount--;
                                                                                          }
                                                                                        }

                                                                                        sum = amount * price;
                                                                                      });

                                                                                      setState(() {});
                                                                                    }),
                                                                              ),
                                                                              Container(
                                                                                  margin: EdgeInsets.only(left: 10),
                                                                                  child: Text(
                                                                                    amount.toString(),
                                                                                    style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                  )),
                                                                              Container(
                                                                                margin: EdgeInsets.only(left: 10),
                                                                                width: 30,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: Color(0xffff5f9fd),
                                                                                  boxShadow: [
                                                                                    BoxShadow(color: Color(0xff475269).withOpacity(0.3), blurRadius: 5, spreadRadius: 1)
                                                                                  ],
                                                                                ),
                                                                                child: IconButton(
                                                                                  icon: Icon(
                                                                                    CupertinoIcons.add,
                                                                                    size: 10,
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    setModalState(() {
                                                                                      amount++;
                                                                                      price = pprice[i - 1];
                                                                                      sum = amount * price;
                                                                                    });

                                                                                    setState(() {});
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Spacer(),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                40,
                                                                            height:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                                                                              BoxShadow(
                                                                                color: Color(0xff475269),
                                                                                blurRadius: 5,
                                                                                spreadRadius: 1,
                                                                              ),
                                                                            ]),
                                                                            child:
                                                                                IconButton(
                                                                              icon: Icon(Icons.close),
                                                                              color: Colors.black,
                                                                              onPressed: () {
                                                                                setModalState(() {
                                                                                  Navigator.of(context).pop();
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "\$ $sum",
                                                                            style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.bold),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              button(
                                                                  color:
                                                                      primaryColor,
                                                                  label:
                                                                      "Add to cart",
                                                                  press:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      i = i;
                                                                    });
                                                                    var check =
                                                                        await db
                                                                            .checkcartexist("images/$i.png");
                                                                    if (check!) {
                                                                      List?
                                                                          updatedCart =
                                                                          await db
                                                                              .checkcartamount("images/$i.png");
                                                                      int a = updatedCart![
                                                                              0]
                                                                          [
                                                                          "amount"];

                                                                      var updatecart = await db.updatecart(
                                                                          "images/$i.png",
                                                                          Users(
                                                                            usrName:
                                                                                widget.usrName,
                                                                            usrproduct:
                                                                                usrproduct,
                                                                            productprice:
                                                                                sum,
                                                                            productpicture:
                                                                                "images/$i.png",
                                                                            amount:
                                                                                (amount + a),
                                                                          ));
                                                                      amount =
                                                                          1;
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    } else {
                                                                      cart();
                                                                    }
                                                                  },
                                                                  style1: TextStyle(
                                                                      fontSize:
                                                                          30,
                                                                      color: Colors
                                                                          .white),
                                                                  h: 55)
                                                            ]),
                                                      ),
                                                    )
                                                  ]);
                                            }));
                                      });
                                    });
                              },
                            );
                          })
                    ]),
              )
            ]),
          ),
      ],
    );
  }
}
