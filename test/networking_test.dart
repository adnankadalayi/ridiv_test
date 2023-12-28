import 'package:flutter_test/flutter_test.dart';
import 'package:ridiv_test/constants.dart';
import 'package:ridiv_test/services/networking.dart';

void main() {
  test('Data fetched from internet', () async {
    final network =
        Networking(url: '$endpoint?q=kochi&appid=$apiKey&units=metric');

    final value = await network.fetchData();

    expect('Kochi', value['name']);
  });
}
