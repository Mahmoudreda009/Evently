import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String title;
  String description;
  String type;
  String image;
  DateTime date;
  String time;

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.image,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "type": type,
      "image": image,
      "date": Timestamp.fromDate(date),
      "time": time,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map, String id) {
    return EventModel(
      id: id,
      title: map["title"],
      description: map["description"],
      type: map["type"],
      image: map["image"],
      date: (map["date"] as Timestamp).toDate(),
      time: map["time"],
    );
  }
}
