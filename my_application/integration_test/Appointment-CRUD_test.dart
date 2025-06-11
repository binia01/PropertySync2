// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
//
// import 'package:my_application/main_widget.dart'; // Adjust if your app's main widget is different
//
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//
//   group('Appointment Flow', () {
//     testWidgets('user can sign up, then navigate to login and log in successfully', (
//         WidgetTester tester,
//         ) async {
//       await tester.pumpWidget(
//         const ProviderScope(
//           child: MainWidget(),
//         ),
//       );
//       await tester.pumpAndSettle();
//
//       expect(find.text('Create your account'), findsOneWidget);
//       expect(find.text('Sign up'), findsOneWidget);
//
//       final Finder signInTextButton = find.widgetWithText(TextButton, 'Sign in');
//       expect(signInTextButton, findsOneWidget);
//
//       await tester.tap(signInTextButton);
//       await tester.pumpAndSettle(); // Wait for navigation to the login screen
//
//       print('--- Verifying Navigation to Login Page ---');
//       expect(find.text('LOG IN TO YOUR ACCOUNT'), findsOneWidget); // Check for login page title.
//
//       print('--- Starting Login Flow ---');
//
//       // Find the login form fields.
//       final Finder emailField = find.byType(TextFormField).at(0);
//       final Finder passwordField = find.byType(TextFormField).at(1);
//
//       // Find the login button using its text.
//       final Finder loginButton = find.text('Login');
//
//       await tester.enterText(emailField, 'buyer1@example.com'); // Use valid test credentials
//       await tester.enterText(passwordField, 'password123'); // Use valid test credentials
//
//
//       // Tap the login button.
//       expect(loginButton, findsOneWidget); // Ensure login button is present.
//       await tester.tap(loginButton);
//       await tester.pumpAndSettle(const Duration(seconds: 3)); // Wait for network call and dialog.
//
//       print('--- Verifying Navigation to Home/Properties after Login ---');
//       expect(find.text('Properties'), findsOneWidget, reason: 'Expected to be on the "Properties" screen after successful login.');
//
//
//       // Find the first property card and tap it.
//       final Finder propertyCard = find.byType(InkWell).first;
//       await tester.tap(propertyCard);
//       await tester.pumpAndSettle();
//
//       expect(find.text('Schedule Appointment for'), findsOneWidget);
//
//       // Schedule an appointment
//       final Finder dateButton = find.textContaining('Date:');
//       await tester.tap(dateButton);
//       await tester.pumpAndSettle();
//
//       // Select today's date
//       await tester.tap(find.text('OK'));
//       await tester.pumpAndSettle();
//
//       final Finder timeButton = find.textContaining('Time:');
//       await tester.tap(timeButton);
//       await tester.pumpAndSettle();
//
//       // Select a time (e.g., the first available time)
//       await tester.tap(find.text('OK'));
//       await tester.pumpAndSettle();
//
//       final Finder scheduleButton = find.text('Schedule');
//       await tester.tap(scheduleButton);
//       await tester.pumpAndSettle(const Duration(seconds: 2));
//
//       // Navigate to the appointment list screen (assuming you have a route or button to do so)
//       // Replace with your actual navigation method
//       // --- NAVIGATE TO APPOINTMENT LIST ---
//       print('--- Navigating to Appointment List via Bottom Navigation Bar ---');
//       // Tap the 'Appointments' tab in the BottomNavigationBar
//
//       await tester.pumpAndSettle(const Duration(seconds: 3)); // Increased from 2 to 3 seconds
//
//       // --- NAVIGATE TO APPOINTMENT LIST ---
//       print('--- Navigating to Appointment List via Bottom Navigation Bar ---');
//       // Tap the 'Appointments' tab in the BottomNavigationBar
//       final Finder appointmentsTab = find.descendant(
//         of: find.byType(BottomNavigationBar),
//         matching: find.byIcon(Icons.calendar_today),
//       );
//       await tester.tap(appointmentsTab);
//       // Wait for the navigation to complete and the new screen to settle, including fetching data.
//       await tester.pumpAndSettle(const Duration(seconds: 3)); // Increased from 2 to 5 seconds. This is key.
//
//       // expect(find.text('Appointments'), findsOneWidget); // Verify we are on the Appointments screen
//
//
//       // await tester.tap(find.byIcon(Icons.calendar_today)); // Example: Assuming a calendar icon in the app bar
//       // await tester.pumpAndSettle();
//
//       // expect(find.text('Appointments'), findsOneWidget);
//
//       // Find the appointment card
//       final Finder editButton = find.widgetWithText(TextButton, 'Edit').last;
//       await tester.tap(editButton);
//       await tester.pumpAndSettle();
//
//       // Tap the "Date:" field and confirm the date picker
//       final Finder dateField = find.textContaining('Date:').last;
//       await tester.tap(dateField);
//       await tester.pumpAndSettle();
//       await tester.tap(find.text('OK')); // Assuming 'OK' confirms the date
//       await tester.pumpAndSettle();
//
//       // Tap the "At:" field and confirm the time picker
//       final Finder timeField = find.textContaining('At:').last;
//       await tester.tap(timeField);
//       await tester.pumpAndSettle();
//       await tester.tap(find.text('OK')); // Assuming 'OK' confirms the time
//       await tester.pumpAndSettle();
//
//       // Tap the "Save" button
//       final Finder saveButton = find.widgetWithText(TextButton, 'Save').last;
//       await tester.tap(saveButton);
//       await tester.pumpAndSettle();
//
//       // Tap the "Delete" button
//       final Finder deleteButton = find.widgetWithText(TextButton, 'Delete').last;
//       await tester.tap(deleteButton);
//       await tester.pumpAndSettle();
//
//       // Assert that the appointment was deleted
//       expect(find.text('Luxury Villa in Miami'), findsNothing);
//     });
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:my_application/main_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Appointment Full CRUD Flow', () {
    testWidgets('user can log in, select a property, and manage an appointment', (
        WidgetTester tester,
        ) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MainWidget(),
        ),
      );
      await tester.pumpAndSettle();

      final Finder signInTextButton = find.widgetWithText(TextButton, 'Sign in');
      expect(signInTextButton, findsOneWidget);
      await tester.tap(signInTextButton);
      await tester.pumpAndSettle();

      // --- Begin Login Flow ---
      expect(find.text('LOG IN TO YOUR ACCOUNT'), findsOneWidget);
      final Finder emailField = find.byType(TextFormField).at(0);
      final Finder passwordField = find.byType(TextFormField).at(1);
      final Finder loginButton = find.text('Login');
      await tester.enterText(emailField, 'buyer1@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // --- Verifying Navigation to Home/Properties and Selecting a Specific Property ---
      expect(find.text('Properties'), findsOneWidget, reason: 'Expected to be on the "Properties" screen after successful login.');

      final Finder miamiPropertyFinder = find.text('Luxury Villa in Miami');

      // Scroll until the "Luxury Villa in Miami" text is visible.
      await tester.scrollUntilVisible(miamiPropertyFinder, 500.0);

      // Tap on the specific property.
      await tester.tap(miamiPropertyFinder);
      await tester.pumpAndSettle();

      // --- Schedule an Appointment ---
      expect(find.text('Schedule Appointment for'), findsOneWidget);
      await tester.tap(find.textContaining('Date:'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.textContaining('Time:'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Schedule'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // --- Navigate to Appointment List ---
      final Finder appointmentsTab = find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.byIcon(Icons.calendar_today),
      );
      await tester.tap(appointmentsTab);
      await tester.pumpAndSettle();

      // Verify screen and wait for data to load
      expect(find.text('Luxury Villa in Miami'), findsOneWidget, reason: 'The new appointment card should be visible.');

      // --- Edit the Appointment ---
      final Finder miamiCard = find.ancestor(of: find.text('Luxury Villa in Miami'), matching: find.byType(Card));
      final Finder editButton = find.descendant(of: miamiCard, matching: find.widgetWithText(ElevatedButton, 'Edit'));
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      // Edit fields and save
      await tester.tap(find.descendant(of: miamiCard, matching: find.textContaining('Date:')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: miamiCard, matching: find.textContaining('At:')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: miamiCard, matching: find.widgetWithText(TextButton, 'Save')));
      await tester.pumpAndSettle();

      // --- Delete the Appointment ---
      final Finder deleteButton = find.descendant(of: miamiCard, matching: find.widgetWithText(ElevatedButton, 'Delete'));
      expect(deleteButton, findsOneWidget);
      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      // Assert that the appointment was deleted
      expect(find.text('Luxury Villa in Miami'), findsNothing);
    });
  });
}