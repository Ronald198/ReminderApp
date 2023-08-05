import 'package:flutter/material.dart';


class ReminderAppPalette { 
  static const MaterialColor mainColor =  MaterialColor( 
    0xFF212E5C, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
     <int, Color>{ 
      50:Color(0xFF1e2953), //10% 
      100:Color(0xFF1a254A), //20% 
      200:Color(0xFF172040), //30% 
      300:Color(0xFF141C37), //40% 
      400:Color(0xFF11172E), //50% 
      500:Color(0xFF0D1225), //60% 
      600:Color(0xFF0D1225), //70% 
      700:Color(0xFF0A0E1C), //80% 
      800:Color(0xFF070912), //90% 
      900:Color(0xFF030509), //100% 
    }, 
  );

  static const Color darkModeBackground = Color.fromARGB(255, 43, 40, 40);
  static const Color todaysColor = Color(0xFFD36912);
  static const Color evenMonthColor = Color(0xFF1F72B6);
  static const Color oddMonthColor = Color(0xFF194E12);
}