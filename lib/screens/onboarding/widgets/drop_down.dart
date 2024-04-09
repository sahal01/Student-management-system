import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';
import 'package:sms/providers/onBoardingProvider.dart';


class DropDown {


  chooseDivision({required BuildContext context, required double w}) {
    return Consumer<OnBoardingProvider>(builder: (
      context,
      provider,
      child,
    ) {
      return Padding(
        padding: const EdgeInsets.only(left: 1.0, right: 1),
        child: Container(
            width: w ,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: dropDownGrey, width: 1)),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: DropdownButtonFormField(
                dropdownColor: dropDownGrey,
                decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none),
                isExpanded: true,
                iconEnabledColor: black,
                hint: Text(
                  "Choose Class",
                  style: Styles().normalS(
                      fontW: FontWeight.w400,
                      fontS: 15,
                      color: white,
                      fontFamily: 'GothamLight'),
                ),
                style: Styles().normalS(
                    fontW: FontWeight.w400,
                    fontS: 16,
                    color: white,
                    fontFamily: 'GothamLight'),
                items: Provider.of<OnBoardingProvider>(context, listen: false)
                    .classDivision
                    .map((value) {
                  return DropdownMenuItem(
                      value: value,
                      onTap: () {
provider.division.text=value;
                      },
                      child: Text(value,style: Styles().normalS(
                          fontW: FontWeight.w600,
                          fontS: 16,
                          color: white,
                          fontFamily: '') ,));
                }).toList(),
                onChanged: (value) {},
              ),
            )),
      );
    });
  }
}
