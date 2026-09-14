import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lance_box/presentation/views/auth/signup_screen.dart';
import 'package:lance_box/presentation/views/dashboard/dashboard.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/add_bank_details_screen.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/create_invoice_sceen.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/invoice_screen.dart';
import 'package:lance_box/presentation/views/dashboard/invoice/preview_invoice.dart';
import 'package:lance_box/presentation/views/dashboard/profile_screen.dart';
import 'package:lance_box/presentation/views/dashboard/receipt_screen.dart';
import 'package:lance_box/presentation/views/dashboard/settings_screen.dart';
import 'package:lance_box/presentation/views/set_up_screen.dart';
import 'package:lance_box/shared/constants/routes.dart';
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
        Routes.signupScreen: (context) => const SignUpScreen(),
        Routes.setupProfileScreen: (context) => const SetUpProfileScreen(),
        Routes.invoiceScreen: (context) => const InvoiceScreen(),
        Routes.createInvoiceScreen: (context) => const CreateInvoiceScreen(),
        Routes.addBankDetailsScreen: (context) => const AddBankDetailsScreen(),
        Routes.previewInvoiceScreen: (context) => const PreviewInvoiceScreen(),
        Routes.dashboard: (context) => const Dashboard(),
        Routes.receiptScreen: (context) => const ReceiptScreen(),
        Routes.settingsScreen: (context) => const SettingsScreen(),
        Routes.profileScreen: (context) => const ProfileScreen(),
      },
    );
  }
}
