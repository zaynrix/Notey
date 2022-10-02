import 'CustomeSvg.dart';
import 'package:flutter/material.dart';
import 'package:notey/resources/color_manager.dart';

class CommonWidget{

   getItem({current,index,iconPath}){
    return  BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: Container(
        decoration: BoxDecoration(
          color: current  !=index ? ColorManager.parent :ColorManager.primary ,
          borderRadius: BorderRadius.all(
              Radius.circular(6.0) //                 <--- border radius here
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomSvgAssets(
            color: current != index ?ColorManager.lightGrey :ColorManager.white ,
            path: iconPath,
          ),
        ),
      ),
      label: '',
      // backgroundColor: Colors.purple,
    );
  }
}