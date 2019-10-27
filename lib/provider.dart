import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Race { Black, White, Hispanic, Asian, Other }
enum Activity { None, Little, Some, Lots }
enum Likes {
  Food,
  Outdoors,
  Pets,
  Games,
  Socializing,
  Reading,
  DateNight,
  Travel
}
enum Comm { Text, Email, Push }

Map likes = {
  Likes.Food: Icons.fastfood,
  Likes.Outdoors: Icons.directions_walk,
  Likes.Pets: Icons.pets,
  Likes.Games: Icons.games,
  Likes.Socializing: Icons.local_drink,
  Likes.Reading: Icons.book,
  Likes.DateNight: Icons.favorite,
  Likes.Travel: Icons.flight
};

var apiKey = 'AIzaSyA7_-4rJMyPdawqe84JadCampBF8FFrmQ0';

class HealthProvider with ChangeNotifier {
  HealthProvider();
  String firstName;
  String lastName;

  int age;
  Race race;
  int zipCode;

  bool medication;
  Activity activity;
  List<Likes> _likes;
  get likes => _likes;
  set likes(likes) {
    _likes = likes;
    addCategoriesByLikes();
    notifyListeners();
  }

  Comm comm;

  List tasks;

  Set categories;

  generateTasks() {}

  searchNearby(double lat, double long, String category) async {}

  addCategoriesByLikes() {
    categories.clear();
    if (_likes.contains(Likes.Food)) {
      categories.add('cafe');
      categories.add('gym');
    }
  }
}
