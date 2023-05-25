import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calmly_app/screens/forgotPasswordScreen/forgotPasswordScreen.dart';
import 'package:calmly_app/screens/forgotPasswordScreen/components/forgotPasswordBody.dart';
import 'package:calmly_app/components/textField.dart';
import 'package:calmly_app/components/button.dart';
import 'package:calmly_app/screens/loginScreen/loginScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  testWidgets('Forgot Password Screen Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: forgotPasswordScreen()));

    // Verify that the screen contains the required widgets
    expect(find.text('reset'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(mainButton), findsOneWidget);

    // Tap on the reset password button
    await tester.tap(find.byType(mainButton));
    await tester.pump();

    // Verify that the password reset email is sent
    expect(find.text('Password reset email sent. Please check your email.'),
        findsOneWidget);
    expect(find.byType(loginScreen), findsOneWidget);
  });

  testWidgets('Forgot Password Body Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: forgotPasswordBody()));

    // Verify that the body contains the required widgets
    expect(find.text('reset'), findsOneWidget);
    expect(find.text('password'), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(textField), findsOneWidget);
    expect(find.byType(mainButton), findsOneWidget);
  });
}
