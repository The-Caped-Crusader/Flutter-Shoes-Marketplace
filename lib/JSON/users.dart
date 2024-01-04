import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? usrId;
  final String? fullName;
  final String? email;
  final String? usrName;
  final String? password;
  final String? usrproduct;
  final int? productprice;
  final String? productpicture;
  final int? amount;

  Users({
    this.usrId,
    this.fullName,
    this.email,
     this.usrName,
     this.password,
    this.usrproduct,
    this.productprice,
    this.productpicture,
    this.amount,
  });

  //These json value must be same as your column name in database that we have already defined
  
  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json["usrId"],
        fullName: json["fullName"],
        email: json["email"],
        usrName: json["usrName"],
        password: json["usrPassword"],
        usrproduct: json["usrproduct"],
        productprice: json["productprice"],
        productpicture: json["productpicture"],
        amount:json["amount"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "fullName": fullName,
        "email": email,
        "usrName": usrName,
        "usrPassword": password,
        "usrproduct": usrproduct,
        "productprice": productprice,
        "productpicture": productpicture,
        "amount":amount,
      };
}
