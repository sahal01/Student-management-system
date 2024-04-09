import 'package:flutter/material.dart';
import 'package:sms/const/colors.dart';
import 'package:sms/const/styles.dart';

class Inputdecoration {
  inputdecoration({required String hint}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
