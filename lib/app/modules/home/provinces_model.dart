class Provinces {
  String? provinceId;
  String? province;

  Provinces({this.provinceId, this.province});

  Provinces.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['province_id'] = provinceId;
    data['province'] = province;
    return data;
  }

  static List<Provinces> fromJsonList(List list) {
    if (list.length == 0) return List<Provinces>.empty();
    return list.map((item) => Provinces.fromJson(item)).toList();
  }
}
