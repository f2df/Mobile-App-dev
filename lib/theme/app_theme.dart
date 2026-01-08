part of "my_theme.dart";

class AppTheme {
  static bool isDarkMode = false;

  static ThemeData themeData(context, {bool isDarkTheme = false}) {
    TextTheme textTheme = TextTheme(
      displayLarge: MyTextStyle.headline1,
      displayMedium: MyTextStyle.headline2,
      displaySmall: MyTextStyle.headline3,

      /// light text
      headlineMedium: MyTextStyle.headline4,
      headlineSmall: MyTextStyle.headline5,
      titleLarge: MyTextStyle.headline6,
      titleMedium: MyTextStyle.title,

      /// bold text
      titleSmall: MyTextStyle.subtitle,

      /// semi bold
      bodyLarge: MyTextStyle.body1,
      bodyMedium: MyTextStyle.body2,

      /// label
      bodySmall: MyTextStyle.caption,

      /// caption
    );

    return ThemeData(
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: MyColors.appColor,
      ),
      // for others(Android, Fuchsia)
      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MyColors.appColor,
          selectionColor: MyColors.appColor,
          selectionHandleColor: MyColors.appColor),
      primaryColor: isDarkTheme ? Colors.black : MyColors.appColor,

      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : Color(0xFF3F51B5),


      hintColor: isDarkTheme ? Color(0xff280C0B) : Colors.black,

      highlightColor: isDarkTheme ? Color(0xFFFFFFFF) : Color(0x22F16A36),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xFF3F51B5),
//      iconTheme: IconTheme(data: IconThemeData(), child: null),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0x00FFAC30),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Color(0x00FFAC30),
      canvasColor: isDarkTheme ? Colors.black : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MyColors.appColor,
            statusBarIconBrightness: Brightness.light),
      ),
      textTheme: textTheme, colorScheme: ColorScheme.fromSwatch(primarySwatch: MyColors.appColor).copyWith(background: isDarkTheme ? Colors.black : Colors.white),
    );
  }
}
