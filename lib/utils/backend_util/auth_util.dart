import 'dart:convert';
import 'dart:developer';
 import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:meter_app/utils/backend_util/error_util.dart';
import 'package:meter_app/utils/pref_util.dart';

class AuthUtil {
  // static CollectionReference userCollection =
  //     FirebaseFirestore.instance.collection("users");

  static bool validatePhoneNumber(String fullPhoneNumber, String isoCode) {
    try {
      PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
      PhoneNumber phoneNumber = phoneUtil.parse(fullPhoneNumber, isoCode);
      bool isValid = phoneUtil.isValidNumber(phoneNumber);
      return isValid;
    } catch (e) {
      print("Failed to validate phone number: $e");
      return false;
    }
  }

  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }





  final LinearGradient linearGradient = const LinearGradient(
    colors: [
      Color(0xffEFA66F),
      Color(0xffDE8131),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );}
