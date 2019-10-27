import 'dart:convert';

import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pushhealth/task.dart';

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

const List prompts = [
  'Why not hit up ',
  'How bout going to ',
  'Hey, check out '
];

class HealthProvider with ChangeNotifier {
  HealthProvider();
  String firstName;
  String lastName;

  int age;
  Race race;
  int zipCode = 89183;

  bool medication;
  Activity activity;
  Set<Likes> _likes = {};
  Set<Likes> get likes => _likes;
  set likes(likes) {
    _likes = likes;
    addTypesByLikes();
    notifyListeners();
  }

  addLike(Likes like) => _likes.add(like);
  removeLike(Likes like) => _likes.remove(like);
  toggleLike(Likes like) {
    _likes?.contains(like) ?? false ? _likes.remove(like) : _likes.add(like);
    addTypesByLikes();
    print(types);
    print(likes);
    notifyListeners();
  }

  Comm comm;

  List<Task> tasks = [
    //Task(name: 'test task', description: 'test description', type: 'gym')
  ];

  Set types = {'park', 'gym', 'cafe'};

  double lat;
  double lng;

  Future<List<Task>> generateTasks() async {
    tasks.clear();
    print(types);
    print(_likes);
    types.forEach((type) async {
      await searchNearby(lat, lng, type).then((data) {
        print(data);
        print(data['results'][0]);
        var taskData = data['results'][0];
        tasks.add(Task(
          name: randomChoice(prompts) + taskData['name'] + ' today?',
          description: null,
          type: type,
        ));
        return tasks;
      });
    });
    return [];
  }

  Future searchNearby(double lat, double lng, String type) async {
    final String url =
        '$nearbyBaseUrl?key=$apiKey&location=$lat,$lng&radius=10000&type=$type';
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map data = json.decode(response.body);
      return data;
    } else {
      throw Exception('An error occurred getting nearby places');
    }
  }

  getLatLongByZip(int zip) async {
    final String url =
        '$geocodeBaseUrl?key=$apiKey&components=postal_code:$zip';
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      var location = data['results'][0]['geometry']['location'];
      lat = location['lat'];
      lng = location['lng'];
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
      //types.add('physiotherapist');
    }
    if (_likes.contains(Likes.Games)) {
      types.add('bar');
    }
    if (_likes.contains(Likes.Pets)) {
      types.add('pet_store');
    }
  }
}
