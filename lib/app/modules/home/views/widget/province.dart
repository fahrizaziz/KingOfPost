import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:thekingofpost/app/data/config.dart';
import 'package:thekingofpost/app/helpers/shared.dart';
import '../../provinces_model.dart';
import 'package:http/http.dart' as http;
import '../../controllers/home_controller.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({Key? key, required this.tipe}) : super(key: key);
  final String tipe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Provinces>(
        showClearButton: true,
        label: tipe == 'asal' ? 'Provinsi Asal' : 'Provinsi Tujuan',
        hint: 'Pilih Provinsi',
        onFind: (String filter) async {
          Shared().setAuthToken(Config.key);
          final keyApi = await Shared().getAuthToken();
          final response = await http.get(
            Uri.parse(Config.province),
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

            var listAllProvince =
                data['rajaongkir']['results'] as List<dynamic>;

            var models = Provinces.fromJsonList(listAllProvince);
            return models;
          } catch (e) {
            return List<Provinces>.empty();
          }
        },
        // onChanged: (value) => print(value),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              '${item.province}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        onChanged: (prov) {
          if (prov != null) {
            if (tipe == 'asal') {
              controller.hiddenKotaAsal.value = false;
              controller.provAsalId.value = int.parse(prov.provinceId!);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provTujuanId.value = int.parse(prov.provinceId!);
            }
          } else {
            if (tipe == 'asal') {
              controller.hiddenKotaAsal.value = true;
              controller.provAsalId.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provTujuanId.value = 0;
            }
          }
          controller.showButton();
        },
        itemAsString: (item) => item.province!,
        showSearchBox: true,
        searchBoxDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: 'Cari Provinsi ...',
        ),
      ),
    );
  }
}
