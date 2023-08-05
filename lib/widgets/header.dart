import 'package:flutter/material.dart';
import 'package:reminderapp/constants.dart';
import 'package:reminderapp/main.dart';
import 'package:reminderapp/pages/home_page.dart';

PreferredSizeWidget getHeader(BuildContext context) {
  DateTime now = DateTime.now();

  return AppBar(
    title: const Text("Reminder"),
    backgroundColor: ReminderAppPalette.mainColor,
    actions: [
      Stack(
        alignment: Alignment.center, 
        children: [
          IconButton( //changes focus to today
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) {
                    StaticVariables.pageSelectedIndex = 0;
                    
                    return HomePage(animateToSelectedDay: false, animateToToday: true);
                  },
                )
              );
            }, 
            splashRadius: 23,
            icon: const Icon(Icons.calendar_today_rounded, size: 28,),
          ),
          Padding(padding: const EdgeInsets.only(top: 5), child:Text(now.day.toString())) 
        ],
      ),
    ],
  );
}