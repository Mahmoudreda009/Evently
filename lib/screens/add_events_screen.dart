import 'dart:async';

import 'package:evently_assignment/models/event_model.dart';
import 'package:evently_assignment/providers/home_provider.dart';
import 'package:evently_assignment/providers/theme_provider.dart';
import 'package:evently_assignment/screens/home_screen.dart';
import 'package:evently_assignment/ui/utils/app_assets.dart';
import 'package:evently_assignment/ui/utils/app_colors.dart';
import 'package:evently_assignment/ui/utils/app_styles.dart';
import 'package:evently_assignment/widgets/app_text_field.dart';
import 'package:evently_assignment/widgets/evently_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  final EventModel? event;

  const AddEventScreen({super.key, this.event});
  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      final eventOptions = homeProvider.eventOptions;

      if (widget.event == null) {
        homeProvider.setSelectedEventType(eventOptions.first);
        homeProvider.clearSelectedDate();
        homeProvider.clearSelectedTime();
      } else {
        titleController.text = widget.event!.title;
        descController.text = widget.event!.description;

        homeProvider.setSelectedEventType(
          eventOptions.firstWhere(
            (e) => e['title'] == widget.event!.type,
            orElse: () => eventOptions.first,
          ),
        );

        homeProvider.setSelectedDate(widget.event!.date);
        final parts = widget.event!.time.split(":");
        homeProvider.setSelectedTime(
          TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          widget.event == null ? "Add event" : "Edit event",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Consumer2<HomeProvider, ThemeProvider>(
        builder: (context, homeProv, themeProv, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Image.asset(
                            homeProv.selectedEventType?[themeProv.isDark()
                                ? "image_dark"
                                : "image"]!,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemCount: homeProv.eventOptions.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              homeProv.selectedEventType!["title"] ==
                              homeProv.eventOptions[index]["title"];
                          return GestureDetector(
                            onTap: () {
                              homeProv.setSelectedEventType(
                                homeProv.eventOptions[index],
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),

                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    homeProv.eventOptions[index]["icon"]!,
                                    color: isSelected
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimary
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    homeProv.eventOptions[index]["title"]!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: isSelected
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.onPrimary
                                              : Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      "Title",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 18),
                    AppTextField(
                      hint: "Event Title",
                      controller: titleController,
                    ),
                    SizedBox(height: 18),
                    Text(
                      "Description ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 18),
                    AppTextField(
                      hint: "Event Description ",
                      maxLines: 6,
                      controller: descController,
                    ),
                    SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                "Event Date",
                                style: AppTextStyles.black14Medium,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            );
                            if (date != null) {
                              homeProv.setSelectedDate(date);
                            }
                          },
                          child: Text(
                            homeProv.selectedDate == null
                                ? "Choose date"
                                : "${homeProv.selectedDate!.day}/ ${homeProv.selectedDate!.month} / ${homeProv.selectedDate!.year}",

                            style: AppTextStyles.blue14Regular.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_filled_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              Text(
                                "Event Time",
                                style: AppTextStyles.black14Medium,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null) {
                              homeProv.setSelectedTime(time);
                            }
                          },
                          child: Text(
                            homeProv.selectedTime == null
                                ? "Choose time"
                                : "${homeProv.selectedTime!.hour} : ${homeProv.selectedTime!.minute}",

                            style: AppTextStyles.blue14Regular.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    EventlyButton(
                      text: widget.event == null ? "Add event" : "Edit event",
                      onPress: () async {
                        if (homeProv.selectedDate == null ||
                            homeProv.selectedTime == null)
                          return;

                        EventModel event = EventModel(
                          id: widget.event?.id ?? null,
                          title: titleController.text,
                          description: descController.text,
                          type: homeProv.selectedEventType!["title"],
                          image: homeProv.selectedEventType!["image"],
                          date: homeProv.selectedDate!,
                          time:
                              "${homeProv.selectedTime!.hour}:${homeProv.selectedTime!.minute}",
                        );

                        if (widget.event == null) {
                          await homeProv.addEvent(event);
                          Navigator.pop(context);
                        } else {
                          await homeProv.updateEvent(event);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
