import 'dart:convert';

import 'package:get/get.dart';
import 'package:rz_test/model/location_model.dart';
import 'package:rz_test/service/location_service.dart';

class CitiesController extends GetxController {
  List<LocationModel> citiesList = <LocationModel>[].obs;
  RxInt selectedCityID = 0.obs;
  RxString selectedCityName = ''.obs;

  void setCities(List<LocationModel> cities) {
    citiesList.assignAll(cities);
  }

  void setCityID(int id, String name) {
    selectedCityID.value = id;
    selectedCityName.value = name;
  }

  Future<int> getCities(String provinceId) async {
    var response = await LocationService().getCity(provinceId);

    if (response.statusCode == 200) {
      final List<dynamic> cityData = jsonDecode(response.body);
      List<LocationModel> cities =
          cityData.map((data) => LocationModel.fromJson(data)).toList();
      setCities(cities);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
