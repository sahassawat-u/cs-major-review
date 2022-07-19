import 'package:flutter/material.dart';

class TagProvider with ChangeNotifier {
  List<String> _tags = [];
  bool InitTag = false;
  List<String> get tags => _tags;
  // bool isTagged() {
  //   return InitTag;
  // }

  // void setTag(bool tag) {
  //   InitTag = tag;
  //   // notifyListeners();
  // }
  bool isTagsEmpty() {
    return _tags.isEmpty;
  }

  void addTag(String tag) {
    _tags.add(tag);
    print(_tags);
    notifyListeners();
  }

  void removeTag(String tag) {
    _tags.remove(tag);
    print(_tags);
    notifyListeners();
  }

  void reset() {
    _tags = [];
  }

  bool contains(String tag) {
    return _tags.contains(tag);
  }
}
