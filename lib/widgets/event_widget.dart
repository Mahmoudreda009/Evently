import 'package:evently_assignment/ui/event_dm.dart';
import 'package:flutter/cupertino.dart';

class EventWidget extends StatelessWidget {
 final EventDM eventDM;
  const EventWidget({super.key,required this.eventDM});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(eventDM.categoryDM.imagepath),
        Column(
          children: [
            buildDateContainer(),
            buildTitleContainer(),
          ],
        )
      ],
    );
  }

  buildDateContainer() {}

  buildTitleContainer() {}
}

