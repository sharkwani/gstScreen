import 'dart:convert';

import 'package:http/http.dart' as http;

import 'file:///C:/Users/LENOVO/AndroidStudioProjects/gstscreen/lib/domain/ProfileData.dart';

class DataController {
  static Future callHttpClient(String id) async {
    try {
      var response = await http.get(
          Uri.https("semicolin.pythonanywhere.com", "getSearchResult/$id"));
      var responseData = jsonDecode(response.body);
      if (responseData.keys.contains("error")) {
        return false;
      } else {
        ProfileData profileData = new ProfileData(
            responseData["name"],
            responseData["status"],
            responseData["address"],
            responseData["tax payer type"],
            responseData["business type"],
            responseData["date of registration"]);
        return profileData;
      }
    } catch (exception) {
      return true;
    }
  }
}
