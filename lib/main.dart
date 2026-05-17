import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/service/auth_service.dart';
import 'package:proyecto_dam_2526/service/supabase_service.dart';
import 'package:proyecto_dam_2526/utils/AppColors.dart';
import 'package:proyecto_dam_2526/view/administration_screen.dart';
import 'package:proyecto_dam_2526/view/getProduct_screen.dart';
import 'package:proyecto_dam_2526/view/inventory_screen.dart';
import 'package:proyecto_dam_2526/view/login_screen.dart';
import 'package:proyecto_dam_2526/view/profile_screen.dart';
import 'package:proyecto_dam_2526/view/settings_screen.dart';
import 'package:proyecto_dam_2526/view/userHistory_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/addProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/service/database_service.dart';
import 'package:proyecto_dam_2526/viewmodel/addUserForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/administrationScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/getProduct_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/historyRegister_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/inventoryScreen_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/loginForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/messages_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyProductForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/modifyUserForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/newUserPasswordForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/profileForm_viewmodel.dart';
import 'package:proyecto_dam_2526/viewmodel/theme_viewmodel.dart';
import 'package:proyecto_dam_2526/widgets/drawer_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eaqorymjfnwydgfxkikc.supabase.co',
    anonKey: 'sb_publishable_V7nv-Abe7PosATw_yowgRw_2jn0KD_0',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseService()),
        ChangeNotifierProvider(create: (context) => AddProductFormViewModel()),
        ChangeNotifierProvider(
          create: (context) => ModifyProductFormViewmodel(),
        ),
        ChangeNotifierProvider(create: (context) => LoginFormViewmodel()),
        ChangeNotifierProvider(
          create: (context) => AdministrationscreenViewmodel(),
        ),
        ChangeNotifierProvider(create: (context) => AdduserFormViewmodel()),
        ChangeNotifierProvider(create: (context) => ProfileFormViewmodel()),
        ChangeNotifierProvider(create: (context) => ModifyUserFormViewmodel()),
        ChangeNotifierProvider(create: (context) => InventoryScreenViewmodel()),
        ChangeNotifierProvider(create: (context) => GetProductViewmodel()),
        ChangeNotifierProvider(create: (context) => MessagesViewmodel()),
        ChangeNotifierProvider(create: (context) => SupabaseService()),
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => NewUserPasswordFormViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeViewmodel()),
        ChangeNotifierProvider(create: (context) => HistoryRegisterViewmodel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> screens = [
    GetProductScreen(),
    InventoryScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
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
        drawerTheme: DrawerThemeData(
          backgroundColor: AppColors.backgroundColor,
        ),
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
      ),
      darkTheme: ThemeData(
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
          backgroundColor: AppColors.primaryDark,
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
      ),
      themeMode: context.watch<ThemeViewmodel>().theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en'), Locale('es')],
      locale: context.watch<ThemeViewmodel>().currentLang,
      home: PopScope(
        canPop: true,
        child: Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            if (context.watch<AuthService>().userDatabase == null) {
              return Scaffold(body: LoginScreen());
            }
            return Scaffold(
              bottomNavigationBar:
                  context.read<AuthService>().userDatabase == null
                  ? null
                  : BottomNavigationBar(
                      currentIndex: context.watch<AuthService>().selectedScreen,
                      onTap: (value) {
                        setState(() {
                          context.read<AuthService>().selectedScreen = value;
                        });
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.note),
                          label: l10n.obtener,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.inventory),
                          label: l10n.inventario,
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          label: l10n.ajustes,
                        ),
                      ],
                    ),
              appBar: AppBar(title: Center(child: Text(l10n.nombreApp))),
              drawer: context.read<AuthService>().userDatabase == null
                  ? null
                  : DrawerWidget(l10n: l10n),
              body: screens[context.watch<AuthService>().selectedScreen],
            );
          },
        ),
      ),
    );
  }
}
