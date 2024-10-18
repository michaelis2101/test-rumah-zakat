import 'dart:convert';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rz_test/constant/color_collection.dart';
import 'package:rz_test/constant/gap.dart';
import 'package:rz_test/constant/shape.dart';
import 'package:rz_test/controller/cities_controller.dart';
import 'package:rz_test/controller/province_controller.dart';
import 'package:rz_test/controller/user_controller.dart';
import 'package:rz_test/model/location_model.dart';
import 'package:rz_test/service/location_service.dart';
import 'package:rz_test/view/weather.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isProvinceLoading = false;
  bool isCitiesLoading = false;
  ProvinceController getPrivinceList = Get.put(ProvinceController());
  CitiesController getCitiesList = Get.put(CitiesController());
  UserController user = Get.put(UserController());
  final namecont = TextEditingController();
  String selectedProvince = '';
  int selectedProvinceId = 0;
  String selectedCity = '';
  int selectedCityId = 0;

  List<SelectedListItem> provinceData = <SelectedListItem>[];
  List<SelectedListItem> citiesData = <SelectedListItem>[];

  List<SelectedListItem> convertToSelectedList(List<LocationModel> cities) {
    return cities.map((city) {
      return SelectedListItem(name: city.name, value: city.id);
    }).toList();
  }

  void getProvince() async {
    setState(() {
      isProvinceLoading = true;
    });

    try {
      int statuscode = await getPrivinceList.getProvince();

      if (statuscode == 200) {
        // print(getPrivinceList.provinceList[0].name);
        setState(() {
          provinceData = convertToSelectedList(getPrivinceList.provinceList);
        });
      } else {
        Get.snackbar(statuscode.toString(), 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      setState(() {
        isProvinceLoading = false;
      });
    }
  }

  void getCities() async {
    setState(() {
      isCitiesLoading = true;
    });
    int statuscode =
        await getCitiesList.getCities(selectedProvinceId.toString());

    try {
      if (statuscode == 200) {
        // print(getCitiesList.citiesList[0].name);
        setState(() {
          citiesData = convertToSelectedList(getCitiesList.citiesList);
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      setState(() {
        isCitiesLoading = false;
      });
    }
  }

  // var Gap = GapCollection();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProvince();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    namecont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp().celestialBlue,
      body: isProvinceLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            // GapCollection.gap,
                            TextField(
                              controller: namecont,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: ColorApp().indigoGrey))),
                            ),
                            GapCollection.gap,
                            Text(
                              'Select Province',
                              style: GapCollection.inputlabel,
                            ),
                            InkWell(
                              onTap: () {
                                dropdownProvince(context);
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedProvince,
                                        // style: textApp.bodyNormal
                                        //     .copyWith(fontWeight: FontWeight.w400),
                                      ),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        // color: colorApp.dark1,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GapCollection.gap,
                            Text(
                              'Select City',
                              style: GapCollection.inputlabel,
                            ),

                            if (!isCitiesLoading)
                              InkWell(
                                onTap: selectedProvince.isEmpty
                                    ? null
                                    : () {
                                        dropdownCities(context);
                                      },
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedCity,
                                          // style: textApp.bodyNormal
                                          //     .copyWith(fontWeight: FontWeight.w400),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          // color: colorApp.dark1,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            if (isCitiesLoading)
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),

                            GapCollection.Gap(10),

                            SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorApp().indigoGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: () {
                                      if (namecont.text.isEmpty) {
                                        Get.snackbar(
                                            "Warning", 'Name Cannot be Empty',
                                            backgroundColor: Colors.white);
                                      } else if (selectedCity.isEmpty) {
                                        Get.snackbar(
                                            "Warning", 'City Cannot be Empty',
                                            backgroundColor: Colors.white);
                                      } else if (selectedProvince.isEmpty) {
                                        Get.snackbar("Warning",
                                            'Province Cannot be Empyt',
                                            backgroundColor: Colors.white);
                                      } else {
                                        user.setUsername(namecont.text);
                                        Get.to(const WeatherScreen());
                                      }
                                      // Get.to(const WeatherScreen());
                                    },
                                    child: Text(
                                      'Next',
                                      style: GapCollection.inputlabel,
                                    )))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void dropdownProvince(BuildContext context) {
    DropDownState(
      DropDown(
          bottomSheetTitle: Text(
            selectedProvince,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          submitButtonChild: const Text(
            'Done',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          data: provinceData,
          selectedItems: (List<dynamic> selectedList) async {
            if (selectedList.isNotEmpty &&
                selectedList.first is SelectedListItem) {
              getPrivinceList.setProvinceName(
                  (selectedList.first as SelectedListItem).name);
              setState(() {
                selectedProvince =
                    (selectedList.first as SelectedListItem).name;
                selectedProvinceId =
                    int.parse((selectedList.first as SelectedListItem).value!);

                selectedCity = '';
                selectedCityId = 0;
                // selectedDistrict = '';
                // selectedDistrictId = 0;
              });
              getCities();
              print(selectedProvince);
            }
          },
          enableMultipleSelection: false,
          // searchBoxStyle: null,
          isSearchVisible: true),
    ).showModal(context);
  }

  void dropdownCities(BuildContext context) {
    DropDownState(
      DropDown(
          bottomSheetTitle: Text(
            selectedCity,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          submitButtonChild: const Text(
            'Done',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          data: citiesData,
          selectedItems: (List<dynamic> selectedList) async {
            if (selectedList.isNotEmpty &&
                selectedList.first is SelectedListItem) {
              String city = (selectedList.first as SelectedListItem).name;
              List<String> splittingCity = city.split(' ');

              setState(() {
                if (splittingCity[0] == 'KOTA' ||
                    splittingCity[0] == 'KABUPATEN') {
                  city = splittingCity[1];

                  print(city);
                }
                selectedCity = (selectedList.first as SelectedListItem).name;
                selectedCityId =
                    int.parse((selectedList.first as SelectedListItem).value!);

                getCitiesList.setCityID(selectedCityId, city);
                // getCitiesList.set

                // selectedCity = '';
                // selectedCityId = 0;
                // selectedDistrict = '';
                // selectedDistrictId = 0;
              });
              getCities();
              // print(selectedProvince);
            }
          },
          enableMultipleSelection: false,
          // searchBoxStyle: null,
          isSearchVisible: true),
    ).showModal(context);
  }
}
