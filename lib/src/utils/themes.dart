import 'package:deliverify/src/utils/Constants.dart';
import 'package:flutter/material.dart';

ThemeData dark(BuildContext context) {
  return ThemeData.dark().copyWith(
    hintColor: Color.fromARGB(192, 228, 226, 226),
    scaffoldBackgroundColor: darkBody,
    bottomAppBarColor: darkBody,
    iconTheme: IconThemeData(
      color: darkIcon,
    ),
    backgroundColor: darkBody,
    appBarTheme: AppBarTheme(
      color: logoColor,
      titleTextStyle: TextStyle(
          color: appBarTitle, fontSize: 23, fontWeight: FontWeight.w600),
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: darkText,
        ),
    colorScheme: ThemeData().colorScheme.copyWith(primary: darkIcon),
  );
}

ThemeData light(BuildContext context) {
  return ThemeData.dark().copyWith(
    hintColor: Color.fromARGB(225, 90, 90, 90),
    scaffoldBackgroundColor: lightbody,
    primaryColorLight: lightIcon,
    cardColor: lightIcon,
    primaryColor: lightIcon,
    bottomAppBarColor: logoColor,
    iconTheme: IconThemeData(
      color: lightIcon,
    ),
    backgroundColor: lightbody,
    appBarTheme: AppBarTheme(
      foregroundColor: lightIcon,
      color: logoColor,
      titleTextStyle: TextStyle(
          color: appBarTitle, fontSize: 20, fontWeight: FontWeight.w500),
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: lightText,
        ),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: lightIcon,
        ),
  );
}
