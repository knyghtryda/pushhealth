import 'package:flutter/cupertino.dart';

enum Race { Black, White, Hispanic, Asian, Other }
enum Activity { None, Little, Some, Lots }
enum Likes { Food, Outdoors, Pets, Games, Socializing, Reading, DateNight }

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
