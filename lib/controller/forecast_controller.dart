import 'dart:convert';

import 'package:get/get.dart';
import 'package:rz_test/model/forecast_model.dart';
import 'package:rz_test/service/weather_service.dart';

class ForecastController extends GetxController {
  RxBool isLoading = false.obs;

  // Observable list for the forecast items
  RxList<ForecastModel> forecastList = <ForecastModel>[].obs;
  // RxList<Map<String, dynamic>> forecastList = <Map<String, dynamic>>[].obs;

  void setForecast(List<ForecastModel> param) {
    forecastList.assignAll(param);
  }

  Future<int> fetchForecast(String city) async {
    isLoading.value = true;
    try {
      var response = await WeatherService().getForecast(city);

      if (response.statusCode == 200) {
        final forecastData = json.decode(response.body);

        List<ForecastModel> forecasts = (forecastData['list'] as List)
            .map((data) => ForecastModel.fromJson(data as Map<String, dynamic>))
            .toList();

        setForecast(forecasts);

        print(forecastList.first.main.temp);

        // Example usage of the rain data
        // for (var forecast in forecastList) {
        //   var rainAmount = forecast.rain.the3H;
        //   print('Rain for forecast: $rainAmount');
        // }

        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print('Error fetching forecast: $e');
      return 500;
    } finally {
      isLoading.value = false;
    }
  }

  // Future<int> fetchForecast(String city) async {
  //   // isLoading.value = true;
  //   try {
  //     var response = await WeatherService().getForecast(city);
  //     if (response.statusCode == 200) {

  //       final forecastData = json.decode(response.body);
  //       // print(forecastData['list']);
  //       List<ForecastModel> forecasts = forecastData['list']
  //           .map((data) => ForecastModel.fromJson(data as Map<String, dynamic>))
  //           .toList();

  //       setForecast(forecasts);

  //       // ForecastModel forecastData = ;
  //       forecastList.value = forecastData['list'];

  //       print(forecastList);
  //       return response.statusCode;
  //     } else {
  //       return response.statusCode;
  //     }
  //   } catch (e) {
  //     return 500;
  //   } finally {
  //     // isLoading.value = false;
  //   }
  // }
}
