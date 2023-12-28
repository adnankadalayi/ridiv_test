import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridiv_test/constants.dart';
import 'package:ridiv_test/screens/home_page.dart';
import 'package:ridiv_test/services/networking.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  final location = ''.obs;
  final city = ''.obs;
  final weather = ''.obs;
  final description = ''.obs;
  final iconId = ''.obs;
  final lat = 0.0.obs;
  final lon = 0.0.obs;
  final isLoading = true.obs;
  final image = ''.obs;

  @override
  void onInit() {
    getLocation();
    super.onInit();
  }

  getWeather() async {
    await Networking(
            url: '$endpoint?lat=$lat&lon=$lon&appid=$apiKey&units=metric')
        .fetchData()
        .then((value) {
      processedData(value);
    });
    isLoading.value = false;
    Get.offAll(() => HomePage());
  }

  Future getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // print(permission);
    if (permission == LocationPermission.denied) {
      final request = await Geolocator.requestPermission();
      if (request == LocationPermission.deniedForever) {
        Get.defaultDialog(
          contentPadding: const EdgeInsets.all(30),
          title: 'Permission Denied',
          middleText: 'Please turn on permission for Location',
          confirm: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () async {
              await Geolocator.openLocationSettings();
              Get.back();
            },
            child: const Text(
              'Open Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () async => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    lat.value = position.latitude;
    lon.value = position.longitude;
    getWeather();
  }

  searchWeatherByLocation() async {
    await Networking(url: '$endpoint?q=$city&appid=$apiKey&units=metric')
        .fetchData()
        .then((value) {
      processedData(value);
    });
  }

  processedData(value) {
    if (value != null) {
      location.value = value['name'];
      weather.value = value['main']['temp'].toStringAsFixed(0);
      description.value = value['weather'][0]['description'];
      iconId.value = value['weather'][0]['icon'];
    }
  }
}
