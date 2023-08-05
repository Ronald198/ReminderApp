import 'package:flutter/material.dart';
import 'package:reminderapp/constants.dart';
import 'package:reminderapp/pages/home_page.dart';

class StaticVariables {
  static int pageSelectedIndex = 0;
  static String daySelected = "${DateTime.now().month}_${DateTime.now().day}"; //by default is the current day -> MM_DD format
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ReminderMain()
  );
}

class ReminderMain extends StatefulWidget {
  const ReminderMain({super.key});

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
          labelStyle: TextStyle(color: Colors.black)
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: ReminderAppPalette.mainColor
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor:ReminderAppPalette.darkModeBackground,
        primarySwatch: ReminderAppPalette.mainColor,
        primaryTextTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ReminderAppPalette.mainColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.resolveWith((states) => const Color.fromARGB(178, 17, 35, 100))
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
          labelStyle: TextStyle(color: Colors.white)
        ),
        cardTheme: const CardTheme(
          color: Color.fromARGB(255, 31, 29, 29),
          shadowColor: Color.fromARGB(120, 255, 255, 255)
        ),
        dividerColor: const Color.fromARGB(120, 255, 255, 255),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white
        ),
      ),
      themeMode: _themeMode,
      home: HomePage(animateToSelectedDay: false, animateToToday: false,),
    );
  }
}