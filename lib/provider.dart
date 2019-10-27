import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Race { Black, White, Hispanic, Asian, Other }
enum Activity { None, Little, Some, Lots }
enum Likes { Food, Outdoors, Pets, Games, Socializing, Reading, DateNight }

Map likes = {
  Likes.Food: Icons.fastfood,
  Likes.Outdoors: Icons.directions_walk,
  Likes.Pets: Icons.pets,
  Likes.Games: Icons.games,
  Likes.Socializing: Icons.local_drink,
  Likes.Reading: Icons.book,
  Likes.DateNight: Icons.favorite
};

class HealthProvider with ChangeNotifier {
  String firstName;
  String lastName;

  int age;
  Race race;
  int zipCode;

  bool medication;
  Activity activity;
  List<Likes> likes;
}
