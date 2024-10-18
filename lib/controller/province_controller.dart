import 'dart:convert';

import 'package:get/get.dart';
import 'package:rz_test/model/location_model.dart';
import 'package:rz_test/service/location_service.dart';

class ProvinceController extends GetxController {
  List<LocationModel> provinceList = <LocationModel>[].obs;
  RxString selectedPR = ''.obs;

  void setProvince(List<LocationModel> provinces) {
    provinceList.assignAll(provinces);
  }

  void setProvinceName(String param) {
    selectedPR.value = param;
  }

  Future<int> getProvince() async {
    var response = await LocationService().getProvince();

    if (response.statusCode == 200) {
      // final provinceData = await json.decode(response.body);
      // // List<LocationModel> parseProvince = List<LocationModel> provinces = provinceData
      // List<LocationModel> provinces =
      //     provinceData.map((data) => LocationModel.fromJson(data)).toList();

      // setProvince(provinces);
      final List<dynamic> provinceData = json.decode(response.body);

      List<LocationModel> provinces = provinceData
          .map((data) => LocationModel.fromJson(data as Map<String, dynamic>))
          .toList();

      setProvince(provinces);

      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  // List<LocationModel> parseProvinceList(Map<String, dynamic> json) {
  //   List<LocationModel> provincies = [];

  //   if (json.containsKey('data')) {
  //     provincies = List<LocationModel>.from(json['data'].map((city) {
  //       return LocationModel(id: city['id'].toString(), name: city['name']);
  //     }));
  //   }

  //   return provincies;
  // }
}
