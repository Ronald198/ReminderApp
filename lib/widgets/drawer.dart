import 'package:flutter/material.dart';
import 'package:reminderapp/constants.dart';
import 'package:reminderapp/main.dart';
import 'package:reminderapp/pages/home_page.dart';
import 'package:reminderapp/pages/list_all_events_page.dart';
import 'package:reminderapp/pages/settings_page.dart';

Drawer getDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: ReminderAppPalette.mainColor,
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reminder App', style: TextStyle(fontSize: 24, color: Colors.white),),
              Text("© 2023 Ronald L", style: TextStyle(color: Color.fromARGB(80, 255, 255, 255), fontSize: 12)),
            ],
          ),
        ),
        ListTile(
          title: const Text('Calendar'),
          leading: const Icon(Icons.calendar_month_outlined),
          trailing: StaticVariables.pageSelectedIndex == 0
            ? 
            const Icon(Icons.check)
            : 
            const Icon(Icons.check, color: Colors.transparent,),
          onTap: () {
            if (StaticVariables.pageSelectedIndex == 0)
            {
              Navigator.of(context).pop();
            }
            else
            {
              StaticVariables.pageSelectedIndex = 0;

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => 
                    HomePage(animateToSelectedDay: true, animateToToday: false,),
                )
              );
            }
          },
        ),
        ListTile(
          title: const Text('List all events', style: TextStyle(),),
          leading: const Icon(Icons.list),
          trailing: StaticVariables.pageSelectedIndex == 1
            ? 
            const Icon(Icons.check)
            : 
            const Icon(Icons.check, color: Colors.transparent,),
          onTap: () {
            if (StaticVariables.pageSelectedIndex == 1)
            {
              Navigator.of(context).pop();
            }
            else
            {
              StaticVariables.pageSelectedIndex = 1;

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => 
                    const ListAllEventsPage(),
                )
              );
            }
          },
        ),
        ListTile(
          title: const Text('Settings', style: TextStyle(),),
          leading: const Icon(Icons.settings),
          trailing: StaticVariables.pageSelectedIndex == 2
            ? 
            const Icon(Icons.check,)
            : 
            const Icon(Icons.check, color: Colors.transparent,),
          onTap: () {
            if (StaticVariables.pageSelectedIndex == 2)
            {
              Navigator.of(context).pop();
            }
            else
            {
              StaticVariables.pageSelectedIndex = 2;

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => 
                    const SettingsPage(),
                )
              );
            }
          },
        ),
      ],
    ),
  );
}