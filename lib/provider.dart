import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

const Map likes = {
  Likes.Food: Icons.fastfood,
  Likes.Outdoors: Icons.directions_walk,
  Likes.Pets: Icons.pets,
  Likes.Games: Icons.games,
  Likes.Socializing: Icons.local_drink,
  Likes.Reading: Icons.book,
  Likes.DateNight: Icons.favorite,
  Likes.Travel: Icons.flight
};

const apiKey = 'AIzaSyA7_-4rJMyPdawqe84JadCampBF8FFrmQ0';
const geocodeBaseUrl = 'https://maps.googleapis.com/maps/api/geocode/json';
const nearbyBaseUrl =
    'https://maps.googleapis.com/maps/api/place/nearbysearch/json';

class HealthProvider with ChangeNotifier {
  HealthProvider();
  String firstName;
  String lastName;

  int age;
  Race race;
  int _zipCode;
  get zipCode => zipCode;
  set zipCode(zipCode) {
    _zipCode = zipCode;
    getLatLongByZip(_zipCode);
    notifyListeners();
  }

  bool medication;
  Activity activity;
  List<Likes> _likes;
  get likes => _likes;
  set likes(likes) {
    _likes = likes;
    addTypesByLikes();
    notifyListeners();
  }

  Comm comm;

  List tasks;

  Set types;

  double lat;
  double lng;

  generateTasks() {}

  Future searchNearby(double lat, double lng, String type) async {
    final String url =
        '$nearbyBaseUrl?key=$apiKey&location=$lat,$lng&radius=10000&type=$type';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('An error occurred getting nearby places');
    }
  }

  getLatLongByZip(int zip) async {
    final String url =
        '$geocodeBaseUrl?key=$apiKey&components=postal_code:$zip';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var location = data['results']['geometry']['location'];
      lat = location['lat'];
      lng = location['lng'];
      types.forEach((category) async {
        await searchNearby(lat, lng, category);
      });
    } else {
      throw Exception('An error occurred getting places by zip');
    }
  }

  addTypesByLikes() {
    types.clear();
    if (_likes.contains(Likes.Food)) {
      types.add('cafe');
      types.add('gym');
    }
    if (_likes.contains(Likes.Socializing)) {
      types.add('bar');
      types.add('gym');
      types.add('park');
    }

    if (_likes.contains(Likes.Reading)) {
      types.add('cafe');
      types.add('library');
    }
    if (_likes.contains(Likes.Outdoors)) {
      types.add('park');
      types.add('physiotherapist');
    }
    if (_likes.contains(Likes.Games)) {
      types.add('bar');
    }
    if (_likes.contains(Likes.Pets)) {
      types.add('pet_store');
    }
  }
}
