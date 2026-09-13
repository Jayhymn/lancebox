import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lance_box/presentation/views/auth/signup_screen.dart';
import 'package:lance_box/presentation/views/dashboard/invoice_screen.dart';
import 'package:lance_box/presentation/views/set_up_screen.dart';
import 'package:lance_box/shared/shared.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LanceBox',
      theme: AppThemeData.lightTheme,
      home: const Scaffold(
        appBar: null,
        body: InvoiceScreen(),
      ),
    );
  }
}
