import 'package:evently_assignment/models/event_model.dart';
import 'package:evently_assignment/providers/home_provider.dart';
import 'package:evently_assignment/providers/theme_provider.dart';
import 'package:evently_assignment/screens/add_events_screen.dart';
import 'package:evently_assignment/screens/event_details_screen.dart';
import 'package:evently_assignment/ui/event_dm.dart';
import 'package:evently_assignment/ui/utils/app_assets.dart';
import 'package:evently_assignment/ui/utils/app_styles.dart';
import 'package:evently_assignment/widgets/event_widget.dart';
import 'package:provider/provider.dart';
import '../ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddEventScreen(),
            ),
          );
        },
        child: Icon(Icons.add, color: Theme.of(context).cardColor),
      ),
      body: Consumer2<HomeProvider, ThemeProvider>(
        builder: (context, prov, themeProvider, _) {
          return Column(
            children: [
              SafeArea(child: buildThemeRow(themeProvider)),

              Expanded(
                child: StreamBuilder<List<EventModel>>(
                  stream: prov.eventsStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    List<EventModel> events = snapshot.data!;

                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        EventModel event = events[index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EventDetailsScreen(event: event),
                              ),
                            );
                          },
                          leading: Image.asset(event.image),
                          title: Text(event.title),
                          subtitle: Text(event.description),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddEventScreen(event: event),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget? buildBottomNavigation() => Theme(
    data: ThemeData(canvasColor: Theme.of(context).cardColor),

    child: BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: AppColors.grey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      currentIndex: selectedIndex,
      onTap: (newIndex) {
        selectedIndex = newIndex;
        setState(() {});
      },
      items: [
        buildBottomNavigationBarItem(Icons.home, "Home"),
        buildBottomNavigationBarItem(Icons.favorite_border, "Favorite"),
        buildBottomNavigationBarItem(Icons.person, "Profile"),
      ],
    ),
  );

  buildBottomNavigationBarItem(IconData iconData, String label) =>
      BottomNavigationBarItem(icon: Icon(iconData), label: label);

  Widget buildThemeRow(ThemeProvider themeProvider) => Container(
    decoration: BoxDecoration(),
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: Row(
      children: [
        Text("Dark mode", style: Theme.of(context).textTheme.titleMedium),
        Spacer(),
        Switch(
          value: themeProvider.themeMode == ThemeMode.dark,
          onChanged: (value) {
            themeProvider.updateTheme(value ? ThemeMode.dark : ThemeMode.light);
          },
        ),
      ],
    ),
  );
}
