import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ridiv_test/controller/home_controller.dart';

class Loading extends StatelessWidget {
  Loading({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: SpinKitWave(
          color: Colors.indigo[900],
        ),
      ),
    );
  }
}
