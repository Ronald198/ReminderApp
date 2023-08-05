// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:reminderapp/main.dart';
import 'package:reminderapp/widgets/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

enum AppTheme { light, dark, system }

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  late AppTheme appsTheme;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHeader(context),
      body: getBody(),
    );
  }

  Future<bool> getThemePrefs() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int appThemeSavedValue = prefs.getInt("appTheme")!;

      switch (appThemeSavedValue) {
        case 0:
          appsTheme = AppTheme.light;
          break;
        case 1:
          appsTheme = AppTheme.dark;
          break;
        case 2:
          appsTheme = AppTheme.system;
          break;
      }

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Widget getBody() {
    return FutureBuilder(
      future: getThemePrefs(),
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          if (snapshot.data != true)
          {
            return const Center(
              child: Text("Error while fetching settings data..."),
            );
          }

          return ListView(
            children: [
              const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text("App's theme", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              ),
              RadioListTile<AppTheme>(
                title: const Text("Light theme"),
                value: AppTheme.light,
                groupValue: appsTheme,
                onChanged: (value) async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setInt("appTheme", 0);

                  if (context.mounted)
                  {
                    ReminderMain.of(context).changeTheme(ThemeMode.light);
                  }

                  setState(() {
                    appsTheme = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile<AppTheme>(
                title: const Text("Dark theme"),
                value: AppTheme.dark,
                groupValue: appsTheme,
                onChanged: (value) async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setInt("appTheme", 1);

                  if (context.mounted)
                  {
                    ReminderMain.of(context).changeTheme(ThemeMode.dark);
                  }

                  setState(() {
                    appsTheme = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile<AppTheme>(
                title: const Text("System's theme"),
                value: AppTheme.system,
                groupValue: appsTheme,
                onChanged: (value) async {
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setInt("appTheme", 2);

                  if (context.mounted)
                  {
                    ReminderMain.of(context).changeTheme(ThemeMode.system);
                  }

                  setState(() {
                    appsTheme = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ],
          );
        }
        else if (snapshot.hasError)
        {
          return const Center(
            child: Text("Error while fetching settings data..."),
          );
        }
        else
        {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text("Loading data..."),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}