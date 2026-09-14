import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';
import 'package:lance_box/shared/constants/routes.dart';
import 'package:lance_box/states/invoice_state.dart';
import 'package:lance_box/states/set_up_state.dart';
import 'package:lance_box/states/sign_up_state.dart';

class LanceBoxDrawer extends ConsumerWidget {
  final void Function(int index) onItemTapped;

  const LanceBoxDrawer({
    super.key,
    required this.onItemTapped,
  });

  void _logout(BuildContext context, WidgetRef ref) {
    ref.read(signUpFormProvider.notifier).reset();
    ref.read(setupProvider.notifier).reset();
    ref.read(invoiceProvider.notifier).reset();
    ref.read(invoiceDraftProvider.notifier).reset();
    ref.read(selectedIndexProvider.notifier).state = 0;
    Navigator.of(context).pushNamedAndRemoveUntil(
      Routes.signupScreen,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: AppColors.secondary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors
                  .secondary, // Add background color to make it visible
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      ImagesPaths.close,
                      colorFilter: const ColorFilter.mode(
                          AppColors.white, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(height: 25), // Space between the icons
                  SvgPicture.asset(ImagesPaths.home, width: 150,),
                ],
              ),
            ),
          ),
          // List items
          DrawerItem(
            title: "Invoices",
            leading: ImagesPaths.invoice,
            onTap: () => onItemTapped(0),
          ),
          DrawerItem(
            title: "Profile",
            leading: ImagesPaths.profile,
            onTap: () => onItemTapped(1),
          ),
          DrawerItem(
            title: "Receipts",
            leading: ImagesPaths.receipts,
            onTap: () => onItemTapped(2),
          ),
          DrawerItem(
            title: "Settings",
            leading: ImagesPaths.settings,
            onTap: () => onItemTapped(3),
          ),
          // Spacer to push the "Log out" item to the bottom
          const Spacer(),
          DrawerItem(
            title: "Log Out",
            leading: ImagesPaths.logout,
            onTap: () => _logout(context, ref),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final String leading;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(leading),
      title: Text(
        title,
        style: context.textTheme.titleMedium
            ?.copyWith(color: AppColors.white, fontSize: 18),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap(); // Triggering the passed callback
      },
    );
  }
}
