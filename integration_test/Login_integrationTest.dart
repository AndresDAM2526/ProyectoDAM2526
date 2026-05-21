import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_dam_2526/l10n/app_localizations.dart';
import 'package:proyecto_dam_2526/view/login_screen.dart';
import 'package:proyecto_dam_2526/viewmodel/loginForm_viewmodel.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Se puede iniciar sesión en la aplicación', (
    WidgetTester tester,
  ) async {
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => LoginFormViewmodel(),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final campoEmail = find.byType(TextFormField).first;
      await tester.enterText(campoEmail, 'prueba@gmail.com');
      final campoPass = find.byType(TextFormField).last;
      await tester.enterText(campoPass, '1234');
      await tester.pumpAndSettle();
      final botonLogin = find.byType(ElevatedButton);
      await tester.tap(botonLogin);
      await tester.pumpAndSettle();
    };
  });
}
