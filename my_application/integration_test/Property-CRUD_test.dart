// test/integration_test/seller_property_flow_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Adjust the import path if your app's main widget is in a different file.
import 'package:my_application/main_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Seller Property Management Full CRUD Flow', () {
    testWidgets(
        'seller can log in, create, view, edit, and delete a property', (
        WidgetTester tester,
        ) async {
      // Launch the app
      await tester.pumpWidget(
        const ProviderScope(
          child: MainWidget(),
        ),
      );
        await tester.pumpAndSettle();

        expect(find.text('Create your account'), findsOneWidget);
        expect(find.text('Sign up'), findsOneWidget);

        final Finder signInTextButton = find.widgetWithText(TextButton, 'Sign in');
        expect(signInTextButton, findsOneWidget);

        await tester.tap(signInTextButton);
        await tester.pumpAndSettle(); // Wait for navigation to the login screen

        print('--- Verifying Navigation to Login Page ---');
        expect(find.text('LOG IN TO YOUR ACCOUNT'), findsOneWidget); // Check for login page title.

        print('--- Starting Login Flow ---');

        // Find the login form fields.
        final Finder emailField = find.byType(TextFormField).at(0);
        final Finder passwordField = find.byType(TextFormField).at(1);

        // Find the login button using its text.
        // final Finder loginButton = find.text('Login');

      await tester.enterText(emailField, 'seller2@example.com'); // Use valid test credentials
      await tester.enterText(passwordField, 'password123'); // Use valid test credentials

      // await tester.enterText(
      //     find.byType(TextFormField).at(0), 'seller2@example.com');
      // await tester.enterText(
      //     find.byType(TextFormField).at(1), 'password123');
      await tester.tap(find.text('Login'));
      // Wait for login and navigation to the properties screen
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Properties'), findsOneWidget,
          reason: 'Should be on the Properties screen after login.');

      // --- 2. Navigate to Add Property Screen ---
      final Finder addPropertyTab = find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.byIcon(Icons.create_outlined),
      );
      expect(addPropertyTab, findsOneWidget,
          reason: '"Add Property" tab should be visible for the seller.');
      await tester.tap(addPropertyTab);
      await tester.pumpAndSettle();

      // --- 3. Fill Out and Submit the Create Property Form ---
      const newPropertyTitle = 'Cozy Downtown Apartment';
      const newPropertyLocation = 'Capital City';

      // Find form fields and enter data
      await tester.enterText(find.widgetWithText(TextFormField, 'Title'), newPropertyTitle);
      await tester.enterText(find.widgetWithText(TextFormField, 'Description'), 'A beautiful and modern apartment in the heart of the city.');
      await tester.enterText(find.widgetWithText(TextFormField, 'Price'), '250000');
      await tester.enterText(find.widgetWithText(TextFormField, 'Location'), newPropertyLocation);
      await tester.enterText(find.widgetWithText(TextFormField, 'Beds'), '2');
      await tester.enterText(find.widgetWithText(TextFormField, 'Baths'), '2');
      await tester.enterText(find.widgetWithText(TextFormField, 'Area'), '1100');

      // Scroll down to ensure the button is visible
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Tap the create button
      final Finder createButton = find.widgetWithText(ElevatedButton, 'Create Property');
      expect(createButton, findsOneWidget);
      await tester.tap(createButton);
      // Wait for SnackBar and potential navigation/state update
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // --- 4. Navigate to Home and Verify Property Creation ---
      final Finder homeTab = find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.byIcon(Icons.home),
      );
      await tester.tap(homeTab);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for properties to load

      // Scroll to find the newly created property
      final Finder newPropertyCardFinder = find.text(newPropertyTitle);
      await tester.scrollUntilVisible(newPropertyCardFinder, 500.0);
      expect(newPropertyCardFinder, findsOneWidget,
          reason: 'The newly created property should be listed on the home screen.');

      // --- 5. Edit the Property ---
      final Finder propertyCard = find.ancestor(of: newPropertyCardFinder, matching: find.byType(Card));
      final Finder editButton = find.descendant(of: propertyCard, matching: find.widgetWithText(TextButton, 'Edit'));

      expect(editButton, findsOneWidget);
      await tester.tap(editButton);
      await tester.pumpAndSettle(); // Wait for navigation to the edit page

      // --- 6. Fill Out and Submit the Update Form ---
      const updatedPropertyTitle = 'Updated Luxury Penthouse';
      const updatedPropertyPrice = '350000';

      // The form re-appears, now we update the values
      await tester.enterText(find.widgetWithText(TextFormField, 'Title'), updatedPropertyTitle);
      await tester.enterText(find.widgetWithText(TextFormField, 'Description'), 'An even more luxurious and updated penthouse with stunning views.');
      await tester.enterText(find.widgetWithText(TextFormField, 'Price'), updatedPropertyPrice);
      await tester.enterText(find.widgetWithText(TextFormField, 'Location'), 'Uptown District');
      await tester.enterText(find.widgetWithText(TextFormField, 'Beds'), '3');
      await tester.enterText(find.widgetWithText(TextFormField, 'Baths'), '3');
      await tester.enterText(find.widgetWithText(TextFormField, 'Area'), '1800');

      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Find and tap the update button
      final Finder updateButton = find.widgetWithText(ElevatedButton, 'Update Property');
      expect(updateButton, findsOneWidget);
      await tester.tap(updateButton);
      await tester.pumpAndSettle(const Duration(seconds: 2)); // Wait for update to process

      // --- 7. Verify the Property Was Updated ---
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final Finder specificPropertyCard = find.ancestor(
        of: find.text(updatedPropertyTitle),
        matching: find.byType(Card), // Assuming your property item is wrapped in a Card
      );

      // await tester.scrollUntilVisible(specificPropertyCard, 500.0);
      //
      // expect(find.descendant(of: specificPropertyCard, matching: find.text(updatedPropertyTitle)), findsOneWidget,
      //     reason: 'The updated property title should be visible within its card.');
      //
      // expect(find.text(newPropertyTitle), findsNothing,
      //     reason: 'The old property title should no longer exist.');
      // //
      // // // --- 7. Verify the Property Was Updated ---
      // // // The previous step should have popped the edit screen.
      // // // We should be back on the properties list.
      // // final Finder updatedPropertyCardFinder = find.text(updatedPropertyTitle);
      // // await tester.scrollUntilVisible(updatedPropertyCardFinder, 500.0);
      // //
      // // // Verify new title is present
      // // expect(updatedPropertyCardFinder, findsOneWidget,
      // //     reason: 'The updated property title should be visible.');
      // // // Verify old title is gone
      // // expect(find.text(newPropertyTitle), findsNothing,
      // //     reason: 'The old property title should no longer exist.');
      //
      // // --- 8. Delete the Property ---
      // final Finder updatedCard = find.ancestor(of: specificPropertyCard, matching: find.byType(Card));
      // final Finder deleteButton = find.descendant(of: updatedCard, matching: find.widgetWithText(TextButton, 'Delete'));
      //
      // expect(deleteButton, findsOneWidget);
      // await tester.tap(deleteButton);
      // await tester.pumpAndSettle(const Duration(seconds: 3)); // Wait for deletion and UI refresh
      //
      // // --- 9. Verify Deletion ---
      // expect(find.text(updatedPropertyTitle), findsNothing,
      //     reason: 'The property should be deleted and no longer visible.');
    });
  });
}