import 'package:calmly_app/components/accountCheck.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/components/inputField.dart';
import 'package:calmly_app/components/passwordField.dart';
import 'package:calmly_app/screens/signupScreen/components/signupBackground.dart';
import 'package:calmly_app/screens/signupScreen/components/signupBody.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  testWidgets('Render signupBody', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: signupBody())));

    // Verify that the signupBody widget is rendered
    expect(find.byType(signupBody), findsOneWidget);

    // Verify the presence of key UI elements
    expect(find.text('sign up'), findsOneWidget);
    expect(find.byType(inputField), findsNWidgets(3));
    expect(find.byType(passwordField), findsOneWidget);
    expect(find.byType(mainButton), findsOneWidget);
    expect(find.byType(accountCheck), findsOneWidget);
  });

  testWidgets('Navigate to loginScreen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: signupBody())));

    // Tap on the "LOGIN" link
    await tester.tap(find.text('LOG IN'));
    await tester.pumpAndSettle();

    // Verify redirection to the loginScreen
    expect(find.byType(loginScreen), findsOneWidget);
  });
}
