import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late String username;
  late String role;
  late String email;
  late List<dynamic> forumLikes;
  late List<dynamic> forumDislikes;
  late String picture;
  late int like;
  late int dislike;
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
    this.like = forumLikes?.length ?? 0;
    this.dislike = forumDislikes?.length ?? 0;
    this.picture = picture;
    this.forumLikes = forumLikes ?? [];
    this.forumDislikes = forumDislikes ?? [];
  }

  void updateLikes(String forumId) {
    forumLikes.add(forumId);
    this.like += 1;
    notifyListeners();
  }

  void updatePicture(String picture) {
    this.picture = picture;
    notifyListeners();
  }

  void updateDislikes(String forumId) {
    this.dislike += 1;
    forumDislikes.add(forumId);
    notifyListeners();
  }

  void removeLikes(String forumId) {
    forumLikes.remove(forumId);
    this.like -= 1;
    notifyListeners();
  }

  void removeDislikes(String forumId) {
    forumDislikes.remove(forumId);
    this.dislike -= 1;
    notifyListeners();
  }

  void setName(String username) {
    this.username = username;
    notifyListeners();
  }

  int getLike() {
    print(like);
    return like;
  }

  int getDislike() {
    print(dislike);
    return dislike;
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
