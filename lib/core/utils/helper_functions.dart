import 'package:flutter/material.dart';
import '../../features/home/widgets/feature_container.dart';
import '../../features/resume/screens/widgets/model/selectable_item.dart';
import '../../features/resume/screens/widgets/selectable_item_bottom_sheet.dart';
import '../constants/sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/features/profile/widgets/liquid_menu_overlay.dart';

void launchCategoryBottomSheet({
  required BuildContext context,
  required String title,
  required Map<String, List<SelectableItem>> categoryData,
  required List<String> initiallySelected,
  required int maxSelection,
  required Function(List<String>) onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) => SelectableItemBottomSheet(
      title: title,
      categoryData: categoryData,
      initiallySelected: initiallySelected,
      maxSelection: maxSelection,
      onConfirm: onConfirm,
    ),
  );
}

Widget featureListItem({
  required BuildContext context,
  required VoidCallback onTap,
  required Gradient gradient,
  required String title,
  required String subTitle,
  required Color color,
  required Color colorBg,
  IconData icon = Icons.brush_outlined,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: FeatureContainer(
          gradient: gradient,
          title: title,
          subTitle: subTitle,
          color: color,
          colorBg: colorBg,
          icon: icon,
        ),
      ),
      SizedBox(height: AppSizes.defaultSpaceH(context)),
    ],
  );
}

mixin FormStateMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isSubmitting = false;

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void setSubmitting(bool submitting) {
    if (mounted) {
      setState(() {
        isSubmitting = submitting;
      });
    }
  }

  void showSuccessMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void unfocusAll() {
    FocusScope.of(context).unfocus();
  }
}





void showLiquidMenuOverlay({
  required BuildContext context,
  required String userName,
  required List<String> menuItems,
  required void Function(String item) onMenuItemTap,
}) {
  final overlay = OverlayEntry(
    builder: (_) => LiquidMenuOverlay(
      backgroundWidget: _buildCurrentPageSnapshot(context),
      userName: userName,
      menuItems: menuItems,
      onClose: () => _closeOverlay(context),
      onMenuItemTap: onMenuItemTap,
    ),
  );

  Overlay.of(context).insert(overlay);
  _overlayMap[context] = overlay;
}

final Map<BuildContext, OverlayEntry> _overlayMap = {};

void _closeOverlay(BuildContext context) {
  _overlayMap[context]?.remove();
  _overlayMap.remove(context);
}

Widget _buildCurrentPageSnapshot(BuildContext context) {
  return RepaintBoundary(
    child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const SizedBox.expand(),
      ),
    ),
  );
}

void handleProfileMenuItemTap(BuildContext context, String item) {
  final lower = item.toLowerCase();
  _closeOverlay(context);

  switch (lower) {
    case 'home':
      context.go('/');
      break;
    case 'profile':
      context.go('/profile');
      break;
    case 'settings':
      context.go('/settings');
      break;
    case 'help':
      context.go('/help');
      break;
    case 'logout':
      _showLogoutDialog(context);
      break;
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.go('/login');
          },
          child: const Text('Logout'),
        ),
      ],
    ),
  );
}

void showLiquidMenu({
  required BuildContext context,
  required Widget background,
  required String userName,
}) {
  OverlayEntry? overlay; // Declare first

  overlay = OverlayEntry(
    builder: (_) => LiquidMenuOverlay(
      backgroundWidget: background,
      userName: userName,
      onClose: () {
        overlay?.remove();
      },
      onMenuItemTap: (item) {
        if (item.toLowerCase() != 'logout') {
          overlay?.remove();
        }

        switch (item.toLowerCase()) {
          case 'home':
            context.go('/');
            break;
          case 'profile':
            context.go('/profile');
            break;
          case 'settings':
            context.go('/settings');
            break;
          case 'help':
            context.go('/help');
            break;
          case 'logout':
            _showLogoutDialog(context);
            break;
        }
      },
    ),
  );

  Overlay.of(context).insert(overlay);
}




