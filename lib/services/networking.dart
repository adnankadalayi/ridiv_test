import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Networking {
  final String url;
  Networking({required this.url});

  Future fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var value = jsonDecode(response.body);
        return value;
      } else {
        Get.snackbar('Wrong City', 'Please enter correct City Name');
      }
    } catch (e) {
      print('error = $e');
    }
  }
}
