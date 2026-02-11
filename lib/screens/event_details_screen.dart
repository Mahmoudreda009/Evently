import 'package:evently_assignment/models/event_model.dart';
import 'package:evently_assignment/providers/home_provider.dart';
import 'package:evently_assignment/screens/add_events_screen.dart';
import 'package:evently_assignment/ui/utils/app_assets.dart';
import 'package:evently_assignment/ui/utils/app_colors.dart';
import 'package:evently_assignment/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).primaryColor),
        ),
        title: Text(
          "Event details",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AddEventScreen(event: event),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
                color: Theme.of(context).cardColor,
              ),
              child: Image.asset(AppAssets.editIcon),
            ),
          ),
          Consumer<HomeProvider>(
            builder: (context, prov, _) {
              return GestureDetector(
                onTap: () {
                  prov.deleteEvent(event).then((onValue) {
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade200),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Image.asset(AppAssets.trashIcon),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(children: [Expanded(child: Image.asset(event.image))]),
                SizedBox(height: 20),
                Text(
                  event.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.date_range,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd MMMM').format(event.date!),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              DateFormat(
                                'hh:mm a',
                              ).format(DateFormat('HH:mm').parse(event.time!)),
                              style: AppTextStyles.grey14Regular,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text('Description', style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          event.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
