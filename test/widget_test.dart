import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lance_box/main.dart';

void main() {
  testWidgets('App launches and renders the sign-up screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text("Looks like you're new here!"), findsOneWidget);
    expect(find.text("Let's create your account"), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);
  });

  testWidgets('Sign-up button navigates to profile setup when form is valid',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextFormField).at(0), 'user@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.enterText(find.byType(TextFormField).at(2), 'password123');

    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text("Let's get to know you better"), findsOneWidget);
  });
}