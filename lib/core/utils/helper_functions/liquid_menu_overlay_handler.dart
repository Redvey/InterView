import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/profile/widgets/liquid_menu_overlay.dart';
import '../../../features/resume/widgets/final_step_dialog.dart';
import '../../constants/strings.dart';


final Map<BuildContext, OverlayEntry> _overlayMap = {};

class MenuItems {
  static const String editProfile = AppStrings.editProfile;
  static const String inviteAFriend = AppStrings.inviteAFriend;
  static const String settings = AppStrings.settings;
  static const String helpCenter = AppStrings.helpCenter;
  static const String logout = AppStrings.logout;

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
      menuItems: MenuItems.allItems,
      onClose: onClose ?? () {
        overlay.remove();
        _overlayMap.remove(context);
      },
      onMenuItemTap: onMenuItemTap ?? (item) {
        if (item != MenuItems.logout) {
          overlay.remove();
          _overlayMap.remove(context);
        }
        _handleMenuItemTap(context, item);
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

void _handleMenuItemTap(BuildContext context, String item) {
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
      _showLogoutDialog(context);
      break;
    default:
      debugPrint('Unknown menu item: $item');
  }
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => FinalStepDialog(
      title: 'Logout',
      subTitle: 'Are you sure you want to logout?',
      yes: 'Logout',
      no: 'Cancel',
      navigate: '/login',
    ),
  );
}

void handleProfileMenuItemTap(BuildContext context, String item) {
  _closeOverlay(context);
  _handleMenuItemTap(context, item);
}
