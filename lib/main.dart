import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lance_box/presentation/views/auth/signup_screen.dart';
import 'package:lance_box/presentation/views/dashboard/dashboard.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/bank_details.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/invoice_screen.dart';
import 'package:lance_box/presentation/views/dashboard/profile_screen.dart';
import 'package:lance_box/presentation/views/dashboard/receipt_screen.dart';
import 'package:lance_box/presentation/views/dashboard/settings_screen.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUpScreen(),
        '/setup': (context) => const SetUpProfile(),
        '/invoice': (context) => const InvoiceScreen(),
        '/bankDetails': (context) => const BankDetailsScreen(),
        '/dashboard': (context) => const Dashboard(),
        '/receipt': (context) => const ReceiptScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
