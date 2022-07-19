import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cs_major_review/constaints.dart';
import 'package:cs_major_review/models/api_uni_model.dart';

class ApiService {
  Future<List<ApiUni>?> getUnis() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.endpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ApiUni> model = apiUniFromJson(response.body)
            .where((x) => x.schoolNameEng != null)
            .toList()
            .where((x) => x.schoolNameEng!.isNotEmpty)
            .toList();
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
