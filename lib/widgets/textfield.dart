import 'package:flutter/material.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';

import 'Inputdecoration.dart';


class TextFieldWidget {
  normalTF({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: TextStyle(color: white, fontSize: 16),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25), // Adjust the radius as needed
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  numberTF({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
        keyboardType:TextInputType.number,
      maxLength:15,
      style: TextStyle(color: white, fontSize: 16),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25), // Adjust the radius as needed
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
  Widget emailTF({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      maxLength: 30,
      style: TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25), // Adjust the radius as needed
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }


  passwordTF({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool show,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      validator: validator,
      obscureText: show,
      controller: controller,
      style: Styles().normalS(
          fontW: FontWeight.w400,
          fontS: 14,
          color: white, fontFamily: ''),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8), // Adjust the radius as needed
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25), // Adjust the radius as needed
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  radiusT({
    required double w,
    required TextEditingController controller,
    required TextInputType kType,
    required String hint,
    required Function() onT,
    required bool read,
  }) {
    return SizedBox(
      height: 40,
      width: w,
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        onTap: onT,
        readOnly: read,
        controller: controller,
        keyboardType: kType,
        style: Styles().normalS(
            fontW: FontWeight.w400,
            fontS: 14,
            color: white, fontFamily: ''),
        decoration: Inputdecoration().inputdecoration(
          hint: hint,
        ),
      ),
    );
  }

  maxLengthRadiusT({
    required double w,
    required TextEditingController controller,
    required TextInputType kType,
    required String hint,
    required Function() onT,
    required bool read,
  }) {
    return SizedBox(
      height: 58,
      width: w,
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        onTap: onT,
        readOnly: read,
        controller: controller,
        keyboardType: kType,
        maxLength: 1,
        style: Styles().normalS(
            fontW: FontWeight.w400,
            fontS: 14,
            color: black, fontFamily: ''),
        decoration: Inputdecoration().inputdecoration(
          hint: hint,
        ),
      ),
    );
  }

  radiusT2({
    required double w,
    required TextEditingController controller,
    required TextInputType kType,
    required String hint,
    required Function() onT,
    required bool read,
    required int lines,
  }) {
    return SizedBox(
      width: w,
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        maxLines: lines,
        onTap: onT,
        readOnly: read,
        controller: controller,
        keyboardType: kType,
        decoration: Inputdecoration().inputdecoration(
          hint: hint,
        ),
      ),
    );
  }

  profileT({required String text, required TextEditingController controller}) {
    return TextField(
        readOnly: true,
        style: Styles().normalS(fontW: FontWeight.w400, fontS: 14, color: black, fontFamily: ''),
        decoration: InputDecoration(
          label: Text(
            text,
            style: Styles().normalS(fontW: FontWeight.w400, fontS: 14, color: primary, fontFamily: ''),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: grey),
          ),
        ),
        controller: controller);
  }

  descTF({
    required TextEditingController controller,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: TextInputType.text,
      maxLines: 5,
      style: TextStyle( fontSize: 14),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ), focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.circular(6),
      ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
    );
  }
}
