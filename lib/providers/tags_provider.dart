import 'package:flutter/material.dart';

class TagProvider with ChangeNotifier {
  List<String> _tags = [];
  // bool InitTag = false;
  List<String> get tags => _tags;
  List<String> _uniTags = [];
  List<String> get uniTags => _uniTags;

  void addUniTag(String uni) {
    _uniTags.add(uni);
    notifyListeners();
  }

  void removeUniTag(String uni) {
    _uniTags.remove(uni);
    notifyListeners();
  }

  bool isTagsEmpty() {
    return _tags.isEmpty && _uniTags.isEmpty;
  }

  void addTag(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  void removeTag(String tag) {
    _tags.remove(tag);
    notifyListeners();
  }

  void reset() {
    _tags = [];
  }

  bool containsCourseTag(String tag) {
    return _tags.contains(tag);
  }

  bool containUniTag(String uni) {
    return _uniTags.contains(uni);
  }
}
