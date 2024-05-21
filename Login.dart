import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_example/home_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:form_example/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'end to end test',
    () {
      testWidgets(
        'verify login process with correct username and password',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          final usernameField = find.byType(TextFormField).at(0);
          await tester.ensureVisible(usernameField);
          await tester.enterText(usernameField, '@oktaviacitra');
          await Future.delayed(const Duration(seconds: 2));

          final passwordField = find.byType(TextFormField).at(1);
          await tester.ensureVisible(passwordField);
          await tester.enterText(passwordField, 'gajahbesar');
          await Future.delayed(const Duration(seconds: 2));

          final loginButton = find.byType(ElevatedButton);
          await tester.ensureVisible(loginButton);
          await tester.tap(loginButton);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(HomeScreen), findsOneWidget);
        },
      );

      testWidgets(
        'verify login screen with incorrect username and password',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          final usernameField = find.byType(TextFormField).at(0);
          await tester.ensureVisible(usernameField);
          await tester.enterText(usernameField, '@oktaviacitra');
          await Future.delayed(const Duration(seconds: 2));

          final passwordField = find.byType(TextFormField).at(1);
          await tester.ensureVisible(passwordField);
          await tester.enterText(passwordField, 'gajahkecil');
          await Future.delayed(const Duration(seconds: 2));

          final loginButton = find.byType(ElevatedButton);
          await tester.ensureVisible(loginButton);
          await tester.tap(loginButton);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.text('Invalid username or password'), findsOneWidget);
        },
      );
    },
  );
}
