import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class Weight extends GetView<HomeController> {
  const Weight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.beratC,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Berat Barang',
                hintText: 'Masukan Berat',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.ubahBerat(value),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 150,
            child: DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              showSelectedItem: true,
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                hintText: 'Cara Satuan Berat ...',
                border: OutlineInputBorder(),
              ),
              items: [
                "ton",
                "kwintal",
                "ons",
                "lbs",
                "pound",
                "kg",
                "hg",
                "dag",
                "gram",
                "dg",
                "cg",
                "mg",
              ],
              label: "Satuan Berat",
              selectedItem: 'gram',
              onChanged: (value) => controller.ubahSatuan(value!),
            ),
          )
        ],
      ),
    );
  }
}
