import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rz_test/service/api.dart';

class LocationService {
  String urlProvince = APISettings().provinceEndpoint;
  String urlCity = APISettings().cityEndpoint;

  Future<http.Response> getProvince() async {
    var response = await http.get(Uri.parse(urlProvince));
    // print(response.body);
    return response;
  }

  Future<http.Response> getCity(String provinceId) async {
    var response = await http.get(Uri.parse('$urlCity/$provinceId.json'));
    return response;
  }
}
