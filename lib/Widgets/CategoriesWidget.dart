import 'package:flutter/material.dart';
import '/../constant/const.dart';
class CategoriesWidgit extends StatelessWidget {
  const CategoriesWidgit({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for(int i=1;i<8;i++)

        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(20),
            
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/$i.png",
                width: 40,
                height:40,
                

              ),
              Text(
                "Sandal",
                style: TextStyle(
                fontWeight:FontWeight.bold,
                fontSize:17,
                color:Color(mainColor),
                ),
              )
            
          ]),

        )
      ]),
    );
  }
}