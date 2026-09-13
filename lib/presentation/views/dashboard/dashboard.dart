import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lance_box/presentation/views/dashboard/receipt_screen.dart';
import 'package:lance_box/presentation/widgets/lancebox_drawer.dart';
import 'invoice_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const InvoiceScreen(),
    const ProfileScreen(),
    const ReceiptScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.of(context).pop(); // Close drawer on navigation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        centerTitle: true,
      ),
      drawer: LanceBoxDrawer(onItemTapped: _onItemTapped),
      body: _screens[_selectedIndex],
    );
  }
}
