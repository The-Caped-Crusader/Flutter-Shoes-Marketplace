import 'package:flutter/material.dart';
import 'package:app_project/constant/const.dart';

class  HomeAppBar extends StatelessWidget {
  const HomeAppBar ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:25),
      color:Color(mainColor),
      child :Row(
        children: [
          IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon:Icon(Icons.list_outlined,size: 25,)),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child:Text(
              "The Shoe Spot",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color:Colors.white,

              ),
            
            )
          ),
          
         
         
         
        
        ],
      )
      
    );
  }
}