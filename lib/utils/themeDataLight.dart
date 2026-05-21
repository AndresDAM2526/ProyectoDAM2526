import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';

class ThemeDataCustom {
  ThemeData themeDataLight(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.backgroundColor,
        onPrimary: AppColors.fontColorLight,
        inversePrimary: AppColors.fontColorDarkElevatedButton,
      ),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: AppColors.primary),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.secondary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: AppColors.secondary),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.secondary,
        inactiveTrackColor: AppColors.primary,
        thumbColor: AppColors.secondary,
        overlayColor: AppColors.secondary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.fontColorLight,
          backgroundColor: AppColors.primary,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.backgroundColor,
      ),
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.backgroundColor),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.backgroundColor,
        indicatorColor: AppColors.secondary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        bodyLarge: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        labelLarge: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        bodyMedium: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        bodySmall: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        displayLarge: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        labelSmall: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        labelMedium: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        displayMedium: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        displaySmall: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        headlineLarge: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        headlineMedium: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        headlineSmall: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        titleMedium: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        titleSmall: TextStyle(
          color: AppColors.fontColorLight,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
      ),
    );
  }

  ThemeData themeDataDark(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        surface: AppColors.darkScaffold,
        onPrimary: AppColors.fontColorDarkElevatedButton,
        inversePrimary: AppColors.fontColorDark,
      ),
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.darkScaffold,

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.primaryDark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryDark,
        selectedItemColor: AppColors.secondaryDark,
      ),
      appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryDark),
      drawerTheme: DrawerThemeData(backgroundColor: AppColors.primaryDark),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.primaryDark,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: AppColors.secondaryDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.fontColorDarkElevatedButton,
          backgroundColor: AppColors.secondaryDark,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.secondaryDark,
        inactiveTrackColor: AppColors.primaryDark,
        thumbColor: AppColors.secondaryDark,
        overlayColor: AppColors.secondary,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.primaryDark),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppColors.secondaryDark),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryDark),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondaryDark,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        bodyLarge: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        labelLarge: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        bodyMedium: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        bodySmall: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        displayLarge: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        labelSmall: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        labelMedium: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        displayMedium: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        displaySmall: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        headlineLarge: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        headlineMedium: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        headlineSmall: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        titleMedium: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
        titleSmall: TextStyle(
          color: AppColors.fontColorDark,
          fontSize: context.watch<ThemeViewmodel>().fontSize,
        ),
      ),
    );
  }
}
