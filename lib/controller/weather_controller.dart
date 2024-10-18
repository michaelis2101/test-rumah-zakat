import 'dart:convert';

import 'package:get/get.dart';
import 'package:rz_test/model/weather_model.dart';
import 'package:rz_test/service/weather_service.dart';

class WeatherController extends GetxController {
  RxBool isLoading = false.obs;

  List<Weather> weather = <Weather>[].obs;
  RxDouble temp = 0.0.obs;
  RxInt hum = 0.obs;
  RxString name = ''.obs;
  RxString icon = ''.obs;
  RxString des = ''.obs;
  RxInt statusCode = 0.obs;

  void setWeather(List<Weather> param) {
    weather.assignAll(param);
  }

  Rx<WeatherModel> selectedWeather = WeatherModel(
          coord: Coord(lon: 0.0, lat: 0.0),
          weather: [],
          base: '',
          main: Main(
              temp: 0,
              feelsLike: 0,
              tempMin: 0,
              tempMax: 0,
              pressure: 0,
              humidity: 0,
              seaLevel: 0,
              grndLevel: 0),
          visibility: 0,
          wind: Wind(speed: 0, deg: 0, gust: 0),
          rain: Rain(the1H: 0),
          clouds: Clouds(all: 0),
          dt: 0,
          sys: Sys(type: 0, id: 0, country: '', sunrise: 0, sunset: 0),
          timezone: 0,
          id: 0,
          name: '',
          cod: 0)
      .obs; //gagal model tidk bisa dibuat observeable karena variabel didalamnya tidak menjadi global

  Future<int> fetchWeather(String city) async {
    isLoading.value = true;
    // isLoading(true);
    try {
      var response = await WeatherService().getWeateherData(city);
      statusCode.value = response.statusCode;

      Map<String, dynamic> fetchedWeather = jsonDecode(response.body);
      // selectedWeather.value = fetchedWeather;
      // print(fetchedWeather);

      if (response.statusCode == 200) {
        // List<Weather> ww = fetchedWeather['weather']
        //     .map((data) => Weather.fromJson(data as Map<String, dynamic>))
        //     .toList();
        temp.value = fetchedWeather['main']['temp'];
        hum.value = fetchedWeather['main']['humidity'];
        name.value = fetchedWeather['name'];
        icon.value = fetchedWeather['weather'][0]['icon'];
        des.value = fetchedWeather['weather'][0]['main'];
        // setWeather(ww);
        // weather.value = fetchedWeather['weather'];

        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      return 500;
    } finally {
      isLoading.value = false;
    }
  }
}
