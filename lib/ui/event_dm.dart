import 'package:flutter/cupertino.dart';

class EventDM {
  CategoryDM categoryDM;
  String title;
  String description;
  DateTime dateTime;

  EventDM({
    required this.categoryDM,
    required this.title,
    required this.description,
    required this.dateTime,
  });
}

class CategoryDM {
  String name;
  String imagepath;
  IconData icon;

  CategoryDM({required this.name, required this.imagepath, required this.icon});
}
