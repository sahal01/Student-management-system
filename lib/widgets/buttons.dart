import 'package:flutter/material.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';



class Buttons{

  primaryB({required double w, required String title, required Function onT,}){
    return MaterialButton(
      minWidth: w,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      height: 45,
      color: primary,
      onPressed: (){
        onT();
      },
      child: Text(
        title,
        style: Styles().normalS(
          fontW: FontWeight.w600,
          fontS: 16,
          color: white, fontFamily: '',
        ),
      ),
    );
  }

  borderB({required double w, required String title, required Function() onT,required Color color,required Color textColor,}){
    return MaterialButton(
      minWidth: w,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: primary)
      ),
      height: 50,
      color: color,
      onPressed: onT,
      child: Text(
        title,
        style: Styles().normalS(
          fontW: FontWeight.w500,
          fontS: 13,
          color: textColor, fontFamily: '',
        ),
      ),
    );
  }

  normalB({required double w,required double h, required String title, required Function() onT,required Color color,required TextStyle style,required double radius}){
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: w,
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
      ),
      height: h,
      color: color,
      padding: EdgeInsets.only(),
      onPressed: onT,
      child: Center(
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }

}