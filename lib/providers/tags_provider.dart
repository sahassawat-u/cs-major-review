import 'package:flutter/material.dart';

class TagProvider with ChangeNotifier {
  List<String> _tags = [];

  List<String> get tags => _tags;

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

  bool contains(String tag) {
    return _tags.contains(tag);
  }
}
