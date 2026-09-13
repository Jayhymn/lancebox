import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lance_box/app.dart';

class LanceBoxDrawer extends StatelessWidget {
  final void Function(int index) onItemTapped;

  const LanceBoxDrawer({
    super.key,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.secondary,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors
                  .secondary, // Add background color to make it visible
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    ImagesPaths.close,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 25), // Space between the icons
                SvgPicture.asset(ImagesPaths.home),
              ],
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
            onTap: () => onItemTapped(4), // Ensure the correct index
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
