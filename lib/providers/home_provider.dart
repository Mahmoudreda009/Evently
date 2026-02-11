import 'package:evently_assignment/models/event_model.dart';
import 'package:evently_assignment/services/event_firebase_service.dart';
import 'package:evently_assignment/ui/utils/app_assets.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> eventOptions = [
    {
      "image": AppAssets.sport,
      "image_dark": AppAssets.sportDark,
      "title": "Sport",
      "icon": Icons.menu_book,
    },
    {
      "image": AppAssets.bookClub,
      "image_dark": AppAssets.bookDark,
      "title": "Book club",
      "icon": Icons.directions_bike_rounded,
    },
    {
      "image": AppAssets.BirthDay,
      "image_dark": AppAssets.BirthdayDark,
      "title": "Birthday",
      "icon": Icons.cake_outlined,
    },
  ];

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void clearSelectedDate() {
    _selectedDate = null;
    notifyListeners();
  }

  TimeOfDay? _selectedTime;
  TimeOfDay? get selectedTime => _selectedTime;
  void setSelectedTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }

  void clearSelectedTime() {
    _selectedTime = null;
    notifyListeners();
  }

  Map<String, dynamic>? _selectedEventType;
  Map<String, dynamic>? get selectedEventType => _selectedEventType;
  void setSelectedEventType(Map<String, dynamic> date) {
    _selectedEventType = date;
    notifyListeners();
  }

  final EventFirebaseService _service = EventFirebaseService();

  Stream<List<EventModel>> get eventsStream => _service.getEvents();

  Future<void> addEvent(EventModel event) async {
    await _service.addEvent(event);
  }

  Future<void> updateEvent(EventModel event) async {
    await _service.updateEvent(event);
  }

  Future<void> deleteEvent(EventModel event) async {
    await _service.deleteEvent(event);
  }
}
