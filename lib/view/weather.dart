import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rz_test/constant/color_collection.dart';
import 'package:rz_test/constant/gap.dart';
import 'package:rz_test/controller/cities_controller.dart';
import 'package:rz_test/controller/forecast_controller.dart';
import 'package:rz_test/controller/province_controller.dart';
import 'package:rz_test/controller/user_controller.dart';
import 'package:rz_test/controller/weather_controller.dart';
import 'package:rz_test/model/forecast_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherController weatherController = Get.put(WeatherController());
  ForecastController forecastController = Get.put(ForecastController());
  CitiesController selectedCity = Get.put(CitiesController());
  ProvinceController selectedProvince = Get.put(ProvinceController());
  UserController user = Get.put(UserController());

  int statusCode = 0;
  int forecastStatus = 0;

  void fetchWeatherStatus() async {
    statusCode = await weatherController
        .fetchWeather(selectedCity.selectedCityName.value);
    setState(() {});
  }

  void fetchForecast() async {
    forecastStatus = await forecastController
        .fetchForecast(selectedCity.selectedCityName.value);
    setState(() {});
  }

  List<Map<String, dynamic>> groupForecastByDate(
      List<ForecastModel> forecastList) {
    final Map<String, List<ForecastModel>> groupedForecasts = {};
    final DateFormat formatter =
        DateFormat('yyyy-MM-dd'); // Define the date format

    // Group forecasts by date
    for (var forecast in forecastList) {
      final String date =
          formatter.format(forecast.dtTxt); // Format DateTime to 'YYYY-MM-DD'

      if (!groupedForecasts.containsKey(date)) {
        groupedForecasts[date] = [];
      }
      groupedForecasts[date]!.add(forecast);
    }

    // Explicitly return the list of maps with 'date' and 'forecasts' keys
    return groupedForecasts.entries.map((entry) {
      return {
        'date': entry.key,
        'forecasts': entry.value, // This is a List<ForecastModel>
      };
    }).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeatherStatus();
    fetchForecast();
  }

  @override
  Widget build(BuildContext context) {
    print('fufufafa : ${weatherController.statusCode.value}');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          centerTitle: true,
        ),
        body: Obx(() {
          if (weatherController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (weatherController.statusCode.value == 404) {
            return const Center(child: Text('City Not Available Yet'));
          } else {
            // var www = weatherController.weather;
            var icon = weatherController.icon;
            var temp = weatherController.temp.value;
            var hum = weatherController.hum.value;
            var name = weatherController.name.value;
            var fc = forecastController.forecastList;

            var groupedForecast = groupForecastByDate(fc);
            print(groupedForecast);
            // print(forecastStatus);
            // print(icon);
            // print(temp);
            // print(hum);
            // print(www.weather[0].icon);
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: ColorApp().indigoGrey,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10))),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                      'https://openweathermap.org/img/wn/${icon}@2x.png'),
                                  // Divider(height: 1),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '$temp°C.',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                      Text(
                                        weatherController.des.value,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.water_drop_rounded,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Text(
                                    //   'Humidity',
                                    //   style: TextStyle(
                                    //       color: Colors.white, fontSize: 20),
                                    // ),
                                    Text(
                                      '$hum%',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                              Text(
                                selectedProvince.selectedPR.value,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              // Icon(
                              //   Icons.water_drop_rounded,
                              //   color: Colors.white,
                              // ),
                              // Icon(
                              //   Icons.water_drop_rounded,
                              //   color: Colors.white,
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome, ${user.username.value},',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                      child: Container(
                    // color: ColorApp().indigoGrey,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: ColorApp().preussianBlue, width: 1)),
                    // height: MediaQuery.of(context).size.height - 350,
                    // width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: groupedForecast.length,
                      itemBuilder: (context, index) {
                        var dayForecast = groupedForecast[index];
                        Object? date = dayForecast['date'];
                        List<ForecastModel>? forecasts =
                            dayForecast['forecasts'];

                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          color: ColorApp().lapisLazuli,
                          child: ExpansionTile(
                            collapsedIconColor: Colors.white,
                            iconColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: ColorApp().celestialBlue,
                            title: Text(
                              'Date: $date',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: forecasts!.length,
                                itemBuilder: (context, forecastIndex) {
                                  var forecast = forecasts[forecastIndex];
                                  return ListTile(
                                    leading: Image.network(
                                      'https://openweathermap.org/img/wn/${forecast.weather[0].icon}@2x.png',
                                    ),
                                    title: Text(
                                      '${forecast.main.temp}°C - ${forecast.weather[0].description}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      'Time: ${forecast.dtTxt}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ))
                ],
              ),
            );
          }
        }));
  }
}
