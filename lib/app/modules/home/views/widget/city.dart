import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:thekingofpost/app/data/config.dart';
import 'package:thekingofpost/app/helpers/shared.dart';
import 'package:thekingofpost/app/modules/home/controllers/home_controller.dart';
import '../../../home/city_model.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    Key? key,
    required this.provId,
    required this.tipe,
  }) : super(key: key);
  final int provId;
  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        label: tipe == 'asal'
            ? 'Kabupaten / Kota Asal'
            : 'Kabupaten / Kota Tujuan',
        hint: 'Pilih Kota',
        onFind: (String filter) async {
          Shared().setAuthToken(Config.key);
          final keyApi = await Shared().getAuthToken();
          final response = await http.get(
            Uri.parse(Config.city + '$provId'),
            headers: {
              'key': keyApi!,
            },
          );
          try {
            var data = jsonDecode(response.body) as Map<String, dynamic>;
            var status = data['rajaongkir']['status']['code'];
            if (status != 200) {
              throw data['rajaongkir']['status']['description'];
            }

            var listAllCity = data['rajaongkir']['results'] as List<dynamic>;

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (e) {
            return List<City>.empty();
          }
        },
        // onChanged: (value) => print(value),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              '${item.type} ${item.cityName}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        itemAsString: (item) => item.cityName!,
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: 'Cari Kota / Kabupaten ...',
        ),
        showClearButton: true,
        onChanged: (cityValue) {
          if (cityValue != null) {
            if (tipe == 'asal') {
              controller.kotaAsalId.value = int.parse(cityValue.cityId!);
            } else {
              controller.kotaTujuanId.value = int.parse(cityValue.cityId!);
            }
          } else {
            if (tipe == 'asal') {
              // controller.hiddenKotaAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
              // controller.hiddenKotaTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
          }
          controller.showButton();
        },
      ),
    );
  }
}
