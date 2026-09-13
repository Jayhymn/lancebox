import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lance_box/presentation/views/dashboard/profile_screen.dart';
import 'package:lance_box/presentation/views/dashboard/receipt_screen.dart';
import 'package:lance_box/presentation/widgets/lancebox_drawer.dart';
import 'invoice/invoice_screen.dart';
import 'settings_screen.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the selectedIndexProvider to get the current index
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> screens = [
      const InvoiceScreen(),
      const ProfileScreen(),
      const ReceiptScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: null,
        centerTitle: true,
      ),
      drawer: LanceBoxDrawer(
        onItemTapped: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
          Scaffold.of(context).closeDrawer();
        },
      ),
      body: screens[selectedIndex], // Display the selected screen
    );
  }
}


final selectedIndexProvider = StateProvider<int>((ref) => 0);