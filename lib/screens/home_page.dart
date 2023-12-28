import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridiv_test/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _controller = Get.put(HomeController());
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/clear-sky.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
                    child: TextField(
                      controller: textEditingController,
                      onSubmitted: (value) {
                        _controller.city.value = value;
                        _controller.searchWeatherByLocation();
                        textEditingController.clear();
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 30,
                        ),
                        // hintText: 'Search cities',
                        label: const Text('Search cities'),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.grey.withOpacity(0.5),
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => Flexible(
                    child: Text(
                      _controller.location.value,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Flexible(
                    child: Text(
                      '${_controller.weather.value}°C',
                      style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Flexible(
                    child: Text(
                      _controller.description.value.capitalizeFirst!,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () => _controller.getWeather(),
                  child: const Text('Current Location'),
                ),
              ],
            ),
          )),
    );
  }
}
