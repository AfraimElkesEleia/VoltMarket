import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:volt_market/core/helper/device_utils.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final dark = DeviceUtils.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading:
            showBackArrow
                ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Iconsax.arrow_left,
                    color: dark ? Colors.white : Colors.black87,
                  ),
                )
                : leadingIcon != null
                ? IconButton(
                  onPressed: leadingOnPressed,
                  icon: Icon(leadingIcon),
                )
                : null,
        title: title,
        actions: actions,
      ),
    );
  }
}
