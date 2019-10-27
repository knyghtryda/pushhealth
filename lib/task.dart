import 'package:flutter/material.dart';

class Task {
  final String name;
  final String type;
  final String description;

  Task(this.name, this.type, this.description);

  Widget render() {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text(description),
      ),
    );
  }
}
