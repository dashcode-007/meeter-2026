import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meter_app/utils/backend_util/constant_util.dart';

class ApiServices {
  static Future<http.Response> sendOtp(String number) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "userName": ConstantUtil.messageUserName,
      "number": number,
      "userSender": ConstantUtil.messageSenderName,
      "apiKey": ConstantUtil.messageApiKey,
      "lang": "En"
    });

    final response = await http.post(Uri.parse(ConstantUtil.sendOtp),
        headers: headers, body: body);
    return response;
  }

  static Future<http.Response> verifyCode(String code, int id) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "userName": ConstantUtil.messageUserName,
      "apiKey": ConstantUtil.messageApiKey,
      "lang": "En",
      "code": code,
      "id": id,
      "userSender": ConstantUtil.messageSenderName
    });

    final response = await http.post(Uri.parse(ConstantUtil.verifyOtp),
        headers: headers, body: body);
    return response;
  }
}
