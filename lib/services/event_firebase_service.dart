import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';

class EventFirebaseService {
  final CollectionReference eventsCollection = FirebaseFirestore.instance
      .collection("events");

  Future<void> addEvent(EventModel event) async {
    await eventsCollection.add(event.toMap());
  }

  Future<void> updateEvent(EventModel event) async {
    await eventsCollection.doc(event.id).update(event.toMap());
  }

  Future<void> deleteEvent(EventModel event) async {
    await eventsCollection.doc(event.id).delete();
  }

  Stream<List<EventModel>> getEvents() {
    return eventsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EventModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
