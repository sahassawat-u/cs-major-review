import 'package:cs_major_review/models/api_uni_model.dart';
import 'package:flutter/material.dart';

class UniProvider with ChangeNotifier {
  late List<ApiUni> unis;
  void initUser({required List<ApiUni> unis}) {
    this.unis = unis;
  }

  List<ApiUni> getUnis() {
    return unis;
  }
}
