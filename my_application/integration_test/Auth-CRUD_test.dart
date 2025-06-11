import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_application/main_widget.dart';
import 'package:my_application/utils/app_env.dart';

void main() {
  // Ensure that the Flutter Test framework is initialized for integration tests.
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-End User Flow', () {
    testWidgets('User can sign up, log in, view/edit profile, and delete account', (
        WidgetTester tester,
        ) async {
      // Pump the root widget of your application wrapped in ProviderScope
      // and override isIntegrationTestProvider to true for test-specific logic.
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isIntegrationTestProvider.overrideWithValue(true),
          ],
          child: const MainWidget(),
        ),
      );
      // Wait for the app to settle and all animations to complete.
      await tester.pumpAndSettle();

      // --- 1. Sign Up Flow ---
      print('--- Starting Sign Up Flow ---');

      // Verify the initial "Create your account" text is present on the sign-up screen.
      expect(find.text('Create your account'), findsOneWidget);

      // Find the text form fields and the buyer role chip.
      final Finder signUpFullNameField = find.byType(TextFormField).at(0);
      final Finder signUpEmailField = find.byType(TextFormField).at(1);
      final Finder signUpPasswordField = find.byType(TextFormField).at(2);
      final Finder buyerRoleChip = find.text('Buyer');

      // Find the sign-up button using its assigned Key.
      final Finder signUpButton = find.byKey(const Key('signUpButton'));

      // Enter details into the sign-up form fields.
      await tester.enterText(signUpFullNameField, 'Test User Integration');
      await tester.enterText(signUpEmailField, 'integration_test_user@example.com');
      await tester.enterText(signUpPasswordField, 'Password123!');

      // --- Keyboard Dismissal ---
      // Simulate pressing "Done" or "Enter" on the keyboard to dismiss it.
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(); // Wait for the keyboard to dismiss and UI to stabilize.

      // Tap the "Buyer" role chip to select the user type.
      expect(buyerRoleChip, findsOneWidget); // Ensure the chip is present.
      await tester.tap(buyerRoleChip);
      await tester.pumpAndSettle(); // Wait for UI update after role selection.

      // --- Scroll to Button if Needed ---
      // Find the scrollable widget (e.g., ListView's ScrollableState) that contains the form.
      final Finder signUpListScrollable = find.byType(Scrollable).first;
      expect(signUpListScrollable, findsOneWidget, reason: 'Expected to find a Scrollable widget for the SignUp form ListView.');

      // Scroll the list until the sign-up button is visible on screen.
      await tester.scrollUntilVisible(
        signUpButton,
        50.0, // Scroll up by 50 pixels if needed to make it fully visible.
        scrollable: signUpListScrollable,
      );
      await tester.pumpAndSettle(); // Wait for the scroll animation to complete.

      // Verify the sign-up button is now visible and tappable, then tap it.
      expect(signUpButton, findsOneWidget, reason: "The 'Sign up' button with key 'signUpButton' should be present and visible.");
      await tester.tap(signUpButton);
      await tester.pumpAndSettle(const Duration(seconds: 3)); // Wait for network call and dialog.

      // Assert: Sign-up successful dialog appears.
      expect(find.text('Sign Up Successful'), findsOneWidget);
      await tester.tap(find.text('OK')); // Dismiss the dialog.
      await tester.pumpAndSettle(); // Wait for dialog dismissal and navigation to login.

      // --- 2. Verify Navigation to Login Page ---
      print('--- Verifying Navigation to Login Page ---');
      expect(find.text('LOG IN TO YOUR ACCOUNT'), findsOneWidget); // Check for login page title.

      // --- 3. Login Flow ---
      print('--- Starting Login Flow ---');

      // Find the login form fields.
      final Finder loginEmailField = find.byType(TextFormField).at(0);
      final Finder loginPasswordField = find.byType(TextFormField).at(1);

      // Find the login button using its text.
      final Finder loginButton = find.text('Login');

      // Enter login credentials.
      await tester.enterText(loginEmailField, 'integration_test_user@example.com');
      await tester.enterText(loginPasswordField, 'Password123!');

      // Tap the login button.
      expect(loginButton, findsOneWidget); // Ensure login button is present.
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 3)); // Wait for network call and dialog.

      print('--- Verifying Navigation to Home/Properties after Login ---');
      expect(find.text('Properties'), findsOneWidget, reason: 'Expected to be on the "Properties" screen after successful login.');


      // Assert: Login successful pop-up appears.
      // expect(find.text('Login Successful'), findsOneWidget);
      // await tester.tap(find.text('OK')); // Dismiss the dialog.
      // await tester.pumpAndSettle(); // Wait for dialog dismissal and navigation to home.

      // --- 4. Verify Navigation Bar and Role-Based Icons ---
      print('--- Verifying Navigation Bar ---');

      // Check if the "Property Listings" screen (home screen) is displayed.
      // expect(find.text('Properties'), findsOneWidget);

      // Verify buyer-specific navigation bar icons are present.
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);

      // Verify seller-specific icon is not present for a buyer.
      expect(find.byIcon(Icons.create_outlined), findsNothing);

      // --- 5. Navigate to User Profile Page ---
      print('--- Navigating to Profile ---');

      // Tap the person icon to go to the profile page.
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle(); // Wait for navigation to complete.

      // Assert: User Profile page is displayed.
      expect(find.text('User Profile'), findsOneWidget);

      // --- 6. Read User Data from Profile Page ---
      print('--- Reading User Data ---');

      // Verify the correct user data is displayed on the profile page.
      final Finder profileNameText = find.text('Test User Integration');
      final Finder profileEmailText = find.text('integration_test_user@example.com');
      final Finder profileRoleText = find.textContaining('Property buyer');

      expect(profileNameText, findsOneWidget);
      expect(profileEmailText, findsOneWidget);
      expect(profileRoleText, findsOneWidget);
// --- 7. Edit Profile (Name) ---
      print('--- Editing Profile ---');
      final Finder editButton = find.text('Update Profile');
      expect(editButton, findsOneWidget);
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile'), findsOneWidget);

      // Assuming the order of TextFormFields on your Edit Profile screen:
      final Finder editFirstNameField = find.byType(TextFormField).at(0); // For First Name
      final Finder editLastNameField = find.byType(TextFormField).at(1);  // For Last Name
      final Finder editEmailField = find.byType(TextFormField).at(2);    // For Email

      // Update the name (or first name)
      await tester.enterText(editFirstNameField, 'Updated Test User');
      // If you have a separate last name field, update it as well
      await tester.enterText(editLastNameField, 'Updated Lastname');
      // If email is editable and needs to be re-entered (or confirmed)
      await tester.enterText(editEmailField, 'integration_test_user@example.com'); // Re-enter current email or update if needed

      // IMPORTANT: Dismiss the keyboard after entering text in the last field
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(); // Wait for keyboard to dismiss and UI to stabilize

      final Finder updateProfileButton = find.text('Update Profile'); // Assuming this is the correct text

      // CRITICAL ADDITION: Ensure the update button is visible after keyboard dismissal
      final Finder editProfileScrollable = find.byType(Scrollable).first; // Find the scrollable parent if any
      // if (editProfileScrollable.precache().isNotEmpty) { // Check if a scrollable is found
      //   await tester.scrollUntilVisible(
      //     updateProfileButton,
      //     50.0, // Scroll up by 50 pixels if needed to make it fully visible.
      //     scrollable: editProfileScrollable,
      //   );
      //   await tester.pumpAndSettle();
      // }

      // Verify the update button is found and tap it
      expect(updateProfileButton, findsOneWidget, reason: "The 'Update Profile' button should be present and visible.");
      await tester.tap(updateProfileButton);
      await tester.pumpAndSettle(const Duration(seconds: 3)); // Give time for network call and dialog

      // Now, re-check for the success message. If the backend received the update
      // and processed it, this message should now appear.
      expect(find.text('User updated successfully'), findsOneWidget);
      await tester.pumpAndSettle(); // Dismiss snackbar/dialog

      // --- 8. Verify Profile Update ---
      print('--- Verifying Profile Update ---');

      // Assert: Back on User Profile page and the updated name is displayed.
      expect(find.text('User Profile'), findsOneWidget);
      expect(find.text('Updated Test User Updated Lastname'), findsOneWidget); // New name should be visible.
      expect(find.text('Test User Integration'), findsNothing); // Old name should be gone.
      expect(find.text('integration_test_user@example.com'), findsOneWidget); // Email should remain the same.

      // --- 9. Delete Account ---
      print('--- Deleting Account ---');

      // Tap the "Delete Account" button.
      final Finder deleteAccountButton = find.text('Delete Account');
      expect(deleteAccountButton, findsOneWidget);
      await tester.tap(deleteAccountButton);
      await tester.pumpAndSettle(); // Wait for confirmation dialog.

      // --- Verify Account Deletion and Redirect ---
      print('--- Verifying Account Deletion and Redirect ---');

      // Assert: App has redirected back to the sign-up page (initial state for new user).
      expect(find.text('Create your account'), findsOneWidget);

      // Assert: No traces of the deleted user's data are present.
      expect(find.text('Updated Test User'), findsNothing);
      expect(find.text('integration_test_user@example.com'), findsNothing);
      expect(find.text('User Profile'), findsNothing);

      print('--- End-to-End Test Completed Successfully ---');
    });
  });
}