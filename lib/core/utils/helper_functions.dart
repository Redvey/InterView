import 'package:flutter/material.dart';
import 'package:interview/features/resume/widgets/final_step_dialog.dart';
import '../../features/home/widgets/feature_container.dart';
import '../../features/profile/data/models/menu_data.dart';
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

final Map<BuildContext, OverlayEntry> _overlayMap = {};

// Standardized menu item constants to avoid mismatches
class MenuItems {
  static const String editProfile = 'Edit Profile';
  static const String inviteAFriend = 'Invite a Friend';
  static const String settings = 'Settings';
  static const String helpCenter = 'Help Center';
  static const String logout = 'Logout';

  static const List<String> allItems = [
    editProfile,
    inviteAFriend,
    settings,
    helpCenter,
    logout,
  ];
}

void showLiquidMenuOverlay({
  required BuildContext context,
  required String userName,
  Widget? backgroundWidget,
  void Function(String item)? onMenuItemTap,
  void Function()? onClose,
}) {
  late OverlayEntry overlay;

  final background = backgroundWidget ?? _buildCurrentPageSnapshot(context);

  overlay = OverlayEntry(
    builder: (_) => LiquidMenuOverlay(
      backgroundWidget: background,
      userName: userName,
      menuItems: defaultMenuItems, // Ensure this matches MenuItems.allItems
      onClose: onClose ??
              () {
            overlay.remove();
            _overlayMap.remove(context);
          },
      onMenuItemTap: onMenuItemTap ??
              (item) {
            // Handle logout separately to keep overlay open during dialog
            if (item != MenuItems.logout) {
              overlay.remove();
              _overlayMap.remove(context);
            }

            _handleMenuItemTap(context, item, overlay);
          },
    ),
  );

  Overlay.of(context).insert(overlay);
  _overlayMap[context] = overlay;
}

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

// Centralized menu item handler using exact string matching
void _handleMenuItemTap(BuildContext context, String item, [OverlayEntry? overlay]) {
  switch (item) {
    case MenuItems.editProfile:
      context.go('/edit-profile');
      break;
    case MenuItems.inviteAFriend:
      context.go('/invite');
      break;
    case MenuItems.settings:
      context.go('/settings');
      break;
    case MenuItems.helpCenter:
      context.go('/help');
      break;
    case MenuItems.logout:
      _showLogoutDialog(context, overlay);
      break;
    default:
    // Handle any unexpected menu items
      debugPrint('Unknown menu item: $item');
      break;
  }
}

// Updated to match the new standardized approach
void handleProfileMenuItemTap(BuildContext context, String item) {
  _closeOverlay(context);
  _handleMenuItemTap(context, item);
}

void _showLogoutDialog(BuildContext context, [OverlayEntry? overlay]) {
  showDialog(
    context: context,
    builder: (context) => FinalStepDialog
      (title: 'Logout', subTitle: 'Are you sure you want to logout?', yes: 'Logout', no: 'Cancel', navigate: '/login'),
  );
}
