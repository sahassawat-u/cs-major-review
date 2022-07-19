import 'dart:convert';

List<ApiUni> apiUniFromJson(String str) =>
    List<ApiUni>.from(json.decode(str).map((x) => ApiUni.fromJson(x)));

String apiUniToJson(List<ApiUni> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiUni {
  ApiUni({
    required this.univMasterName,
    required this.schoolNameEng,
    required this.provinceNameEng,
    required this.latitude,
    required this.longitude,
  });

  String? univMasterName;
  String? schoolNameEng;
  String? provinceNameEng;
  String? latitude;
  String? longitude;

  factory ApiUni.fromJson(Map<String, dynamic> json) => ApiUni(
        univMasterName: json["UNIV_MASTER_NAME"],
        schoolNameEng: json["SchoolNameEng"],
        provinceNameEng: json["province_name_eng"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
      );

  Map<String, dynamic> toJson() => {
        "UNIV_MASTER_NAME": univMasterName,
        "SchoolNameEng": schoolNameEng,
        "province_name_eng": provinceNameEng,
        "Latitude": latitude,
        "Longitude": longitude,
      };
}
