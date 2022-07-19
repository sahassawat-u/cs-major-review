import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late String username;
  late String role;
  late String email;
  late List<dynamic> forumLikes;
  late List<dynamic> forumDislikes;
  late String picture;
  void initUser(
      {required String username,
      required String role,
      required String email,
      required String picture,
      List<dynamic>? forumLikes,
      List<dynamic>? forumDislikes}) {
    this.username = username;
    this.role = role;
    this.email = email;
    this.picture = picture;
    this.forumLikes = forumLikes ?? [];
    this.forumDislikes = forumDislikes ?? [];
  }

  void updateLikes(String forumId) {
    forumLikes.add(forumId);
    notifyListeners();
  }

  void updatePicture(String picture) {
    this.picture = picture;
    notifyListeners();
  }

  void updateDislikes(String forumId) {
    forumDislikes.add(forumId);
    notifyListeners();
  }

  void removeLikes(String forumId) {
    forumLikes.remove(forumId);
    notifyListeners();
  }

  void removeDislikes(String forumId) {
    forumDislikes.remove(forumId);
    notifyListeners();
  }

  String getUsername() {
    return username;
  }

  String getRole() {
    return role;
  }

  String getPicture() {
    return picture;
  }

  String getEmail() {
    return email;
  }

  List<dynamic> getLikes() {
    return forumLikes;
  }

  List<dynamic> getDislikes() {
    return forumDislikes;
  }
}
