import 'package:flutter/material.dart';



class AppColors {

  AppColors._(); // this basically makes it so you can't instantiate this class



  static const Map<int, Color> orange = const <int, Color>{

    50: const Color(0xFFFCF2E7),

    100: const Color(0xFFF8DEC3),

    200: const Color(0xFFF3C89C),

    300: const Color(0xFFEEB274),

    400: const Color(0xFFEAA256),

    500: const Color(0xFFE69138),

    600: const Color(0xFFE38932),

    700: const Color(0xFFDF7E2B),

    800: const Color(0xFFDB7424),

    900: Colors.orange

  };

  static const Map<int, Color> green = const <int, Color>{

    50: const Color(0xFFFCF2E7),

    100: Colors.green,

    200: Colors.lightGreen,

  };

  static const Map<int, Color> deepPurple = const <int, Color>{

    50: Colors.deepPurple,

    100: Colors.deepPurpleAccent

  };

  static const Map<int, Color> white = const <int, Color>{


    100: Colors.white,

    200: Colors.white70,

  };

  static const Map<int, Color> black = const <int, Color>{

    100: Colors.black,
    200: Colors.black45,
    300:Colors.grey,
    400:Colors.black12,
    500:Colors.black26
  };


  static const Map<int, Color> deeppurple = const <int, Color>{

    100: Colors.deepPurple,

  };

  static const Map<int, Color> red = const <int, Color>{

    100: Colors.red,

  };

  static const Map<int, Color> grye = const <int, Color>{

    100: Colors.grey,
    200: const Color(0xFFF1EDE3),

  };

}