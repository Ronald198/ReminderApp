import 'package:flutter/material.dart';
import 'package:reminderapp/constants.dart';
import 'package:reminderapp/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaticVariables {
  static int pageSelectedIndex = 0;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (
    !prefs.containsKey("appTheme")
  )
  {
    await prefs.setInt("appTheme", 2); //system's theme
  }

  runApp(
    ReminderMain(prefs: prefs,)
  );
}

class ReminderMain extends StatefulWidget {
  final SharedPreferences prefs;

  const ReminderMain({super.key, required this.prefs});

  @override
  State<ReminderMain> createState() => _ReminderMainState();

  static _ReminderMainState of(BuildContext context) => context.findAncestorStateOfType<_ReminderMainState>()!;
}

class _ReminderMainState extends State<ReminderMain> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  void initState() {
    super.initState();

    switch (widget.prefs.getInt("appTheme")) {
      case 0:
        _themeMode = ThemeMode.light;
        break;
      case 1:
        _themeMode = ThemeMode.dark;
        break;
      case 2:
        _themeMode = ThemeMode.system;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:Colors.white,
        primaryColor: ReminderAppPalette.mainColor,
        primarySwatch: ReminderAppPalette.mainColor,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ReminderAppPalette.mainColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.resolveWith((states) => const Color.fromARGB(178, 17, 35, 100))
          )
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white
        ),
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        primaryIconTheme: const IconThemeData(
          color: Colors.black
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Color.fromARGB(255, 105, 102, 102))
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: ReminderAppPalette.mainColor
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: ReminderAppPalette.mainColor),
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor:ReminderAppPalette.darkModeBackground,
        primarySwatch: ReminderAppPalette.mainColor,
        primaryTextTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ReminderAppPalette.mainColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(const Color.fromARGB(178, 17, 35, 100)),
          )
        ),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: ReminderAppPalette.darkModeBackground,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        primaryIconTheme: const IconThemeData(
          color: Colors.white
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
          textColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Color.fromARGB(96, 236, 236, 236))
        ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 31, 29, 29),
          shadowColor: Color.fromARGB(120, 255, 255, 255)
        ),
        dividerColor: const Color.fromARGB(120, 255, 255, 255),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(Colors.white),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: ReminderAppPalette.mainColor,
          titleTextStyle: TextStyle(color: Colors.white)
        ),
      ),
      themeMode: _themeMode,
      home: HomePage(animateToSelectedDay: false, animateToToday: false,),
    );
  }
}