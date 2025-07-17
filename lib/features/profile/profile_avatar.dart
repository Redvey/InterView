import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/features/profile/widgets/liquid_menu_overlay.dart';


class ProfileAvatar extends StatefulWidget {
  final double radius;
  const ProfileAvatar({super.key, this.radius = 20});

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showLiquidMenu,
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: const AssetImage(
          'assets/templates/template1.jpeg',
        ),
      ),
    );
  }

  void _showLiquidMenu() {
    if (_isMenuOpen) return;

    _isMenuOpen = true;

    // Get the current page widget to use as background
    final currentWidget = _getCurrentPageWidget();

    // Create overlay with current page as background
    _overlayEntry = OverlayEntry(
      builder: (context) => LiquidMenuOverlay(
        backgroundWidget: currentWidget,
        onClose: _closeLiquidMenu,
        onMenuItemTap: _handleMenuItemTap,
        menuItems: const ["Home", "Profile", "Settings", "Help", "Logout"],
        userName: "Roopam",
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeLiquidMenu() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isMenuOpen = false;
    }
  }

  Widget _getCurrentPageWidget() {
    // You can customize this based on your current route or pass it as a parameter
    // For now, we'll create a simple container that captures the current screen
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Builder(
        builder: (context) {
          // This will capture the current page content
          return Material(
            child: Container(
              color: Colors.transparent,
              child: const SizedBox.expand(),
            ),
          );
        },
      ),
    );
  }

  void _handleMenuItemTap(String item) {
    switch (item.toLowerCase()) {
      case 'home':
        _closeLiquidMenu();
        context.go('/');
        break;
      case 'profile':
        _closeLiquidMenu();
        context.go('/profile');
        break;
      case 'settings':
        _closeLiquidMenu();
        context.go('/settings');
        break;
      case 'help':
        _closeLiquidMenu();
        context.go('/help');
        break;
      case 'logout':
        _showLogoutDialog();
        break;
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _closeLiquidMenu();
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _closeLiquidMenu();
    super.dispose();
  }
}