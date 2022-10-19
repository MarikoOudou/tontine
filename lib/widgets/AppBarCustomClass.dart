import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tontino/services/Colors.dart';

class AppBarCustomClass {
  PreferredSize AppBarCustom() {
    return PreferredSize(
      preferredSize: Size.zero,
      child: AppBar(
        backgroundColor: ColorTheme.primaryColorBlue,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: ColorTheme.primaryColorBlue,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: const Text(''),
      ),
    );
  }
}
