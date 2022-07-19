import 'package:cs_major_review/models/api_uni_model.dart';
import 'package:flutter/material.dart';

class UniProvider with ChangeNotifier {
  late List<ApiUni> unis;
  List<String> uniNames = [];
  void initUni({required List<ApiUni> unis}) {
    this.unis = unis;
    for (var uni in unis) {
      if (uni.schoolNameEng!.isEmpty || uni.schoolNameEng == null) continue;
      uniNames.add(uni.schoolNameEng!);
    }
  }

  List<ApiUni> getUnis() {
    return unis;
  }

  List<String> getUniNames() {
    return uniNames;
  }
}
