import 'package:http/http.dart' as http;
import 'package:rz_test/service/api.dart';

class WeatherService {
  String endpoint = APISettings().endpoint;
  String forecast = APISettings().forecast;
  String key = APISettings().apikey;

  Future<http.Response> getWeateherData(String citysuii) async {
    var response = await http
        .get(Uri.parse('${endpoint}q=$citysuii&appid=$key&units=metric'));

    return response;
  }

  Future<http.Response> getForecast(String citysuii) async {
    var response = await http
        .get(Uri.parse('${forecast}q=$citysuii&appid=$key&units=metric'));

    // print('status = ${response.statusCode}');

    return response;
  }
}
