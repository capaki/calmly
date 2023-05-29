import 'package:calmly_app/components/accountCheck.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/components/inputField.dart';
import 'package:calmly_app/components/passwordField.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/screens/forgotPasswordScreen/forgotPasswordScreen.dart';
import 'package:calmly_app/screens/signupScreen/signupScreen.dart';
import 'package:calmly_app/screens/loginScreen/components/forgotPassword.dart';
import 'package:calmly_app/screens/loginScreen/components/loginBackground.dart';
import 'package:calmly_app/screens/loginScreen/components/loginBody.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Render loginBody', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: loginBody(),
        ),
      ),
    );

    // Verify that the loginBody widget is rendered
    expect(find.byType(loginBody), findsOneWidget);

    // Verify the presence of key UI elements
    expect(find.text('log in'), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(inputField), findsOneWidget);
    expect(find.byType(passwordField), findsOneWidget);
    expect(find.byType(ForgotPassword), findsOneWidget);
    expect(find.byType(mainButton), findsOneWidget);
    expect(find.byType(accountCheck), findsOneWidget);
  });

  testWidgets('Navigate to forgotPasswordScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: loginBody(),
        ),
      ),
    );

    // Tap on the "Forgot password?" link
    await tester.tap(find.text('forgot password?'));
    await tester.pumpAndSettle();

    // Verify redirection to the forgotPasswordScreen
    expect(find.byType(forgotPasswordScreen), findsOneWidget);
  });

  testWidgets('Navigate to signupScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: loginBody(),
        ),
      ),
    );

    // Tap on the "Don't have an account? Sign up" link
    expect(find.text("don't have an account yet? "), findsOneWidget);
    await tester.tap(find.text("SIGN UP"));
    await tester.pumpAndSettle();

    // Verify redirection to the signupScreen
    expect(find.byType(signupScreen), findsOneWidget);
  });
}
