
import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/extensions/responsive_extension.dart';
import '../data/models/metaball_circle.dart';
import '../utils/metaball_config.dart';
import 'animated_menu.dart';
import 'metaball_shapes_painter_v1.dart';

class LiquidMenuOverlay extends StatefulWidget {
  final VoidCallback onClose;
  final Function(String)? onMenuItemTap;
  final List<String> menuItems;
  final Widget backgroundWidget;
  final String userName;

  const LiquidMenuOverlay({
    super.key,
    required this.onClose,
    required this.backgroundWidget,
    this.onMenuItemTap,
    this.menuItems = const ["Home", "Profile", "Settings", "Help", "Logout"],
    this.userName = "Roopam",
  });

  @override
  State<LiquidMenuOverlay> createState() => _LiquidMenuOverlayState();
}

class _LiquidMenuOverlayState extends State<LiquidMenuOverlay>
    with TickerProviderStateMixin {
  List<MetaballCircle> _circles = [];
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  bool _isInit = false;
  bool _showMenu = false;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    // Auto-open the menu when overlay is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openMenu();
    });
  }

  void _initializeCircles() {
    if (!_isInit) {
      final screenSize = MediaQuery.sizeOf(context);
      final topPadding = MediaQuery.paddingOf(context).top;

      _circles = MetaballConfig.createDefaultCircles(screenSize, topPadding);

      _controllers = _circles.map((circle) {
        return AnimationController(
          duration: MetaballConfig.animationDuration,
          vsync: this,
        );
      }).toList();

      _animations = _circles.asMap().entries.map((entry) {
        final index = entry.key;
        final circle = entry.value;
        return Tween<double>(
          begin: circle.baseRadius,
          end: circle.scaledRadius,
        ).animate(
          CurvedAnimation(
            parent: _controllers[index],
            curve: Curves.easeInOut,
          ),
        )
          ..addListener(() {
            if (mounted) {
              setState(() {
                _circles[index] = _circles[index].copyWithScaledRadius(
                  _animations[index].value,
                );
              });
            }
          });
      }).toList();

      setState(() {
        _isInit = true;
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    _initializeCircles();

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Background widget (current page) - slightly dimmed
          // ColorFiltered(
          //   colorFilter: ColorFilter.mode(
          //     Colors.transparent,
          //     BlendMode.multiply,
          //   ),
          //   child: widget.backgroundWidget,
          // ),

          // Metaball animation layer
          _buildMetaballLayer(),

          // Profile button (top-left)
          _buildProfileButton(),

          // Close button (top-right)
          _buildCloseButton(),

          // Menu items with user greeting
          _buildMenuContent(),
        ],
      ),
    );
  }

  Widget _buildMetaballLayer() {
    return AnimatedBuilder(
      animation: Listenable.merge(_animations),
      builder: (context, _) {
        return ClipRRect(
          child: ColorFiltered(
            colorFilter: ColorFilter.matrix(MetaballConfig.metaballColorMatrix),
            child: CustomPaint(
              painter: MetaballShapesPainterV1(circles: _circles),
              size: Size.infinite,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileButton() {
    return Positioned(
      top: context.lgA,
      left: context.lg,
      child: Container(
        height: 40,
        width: 40,
        clipBehavior: Clip.none,
        decoration: const BoxDecoration(
          color: AppColors.blackLight,
          shape: BoxShape.circle,
        ),
        child: AnimatedOpacity(
          opacity: _showMenu ? 0 : 1.0,
          duration: MetaballConfig.animationDuration,
          child: AnimatedContainer(
            duration: MetaballConfig.animationDuration,
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(
              _showMenu ? -70 : 0,
              0,
              0,
            ),
            child: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/templates/template1.jpeg'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return AnimatedPositioned(
      top: MediaQuery.of(context).padding.top + 16,
      right: _showMenu ? 16 : -50,
      duration: MetaballConfig.closeButtonAnimationDuration,
      child: GestureDetector(
        onTap: _closeMenu,
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.close,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // User greeting
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(
              _showMenu ? 0 : -300,
              0,
              0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/templates/template1.jpeg'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hello ${widget.userName}!',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Menu items
          ...widget.menuItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return AnimatedMenuItem(
              text: item,
              index: index + 1, // Offset by 1 to account for user greeting
              showMenu: _showMenu,
              onTap: () => _handleMenuItemTap(item),
            );
          }),
        ],
      ),
    );
  }

  void _openMenu() {
    if (!_showMenu && !_isAnimating) {
      _isAnimating = true;
      for (var controller in _controllers) {
        controller.forward();
      }
      setState(() {
        _showMenu = true;
      });

      // Reset animation flag after animation completes
      Future.delayed(MetaballConfig.animationDuration, () {
        _isAnimating = false;
      });
    }
  }

  void _closeMenu() {
    if (_showMenu && !_isAnimating) {
      _isAnimating = true;
      for (var controller in _controllers) {
        controller.reverse();
      }
      setState(() {
        _showMenu = false;
      });

      // Close overlay after animation completes
      Future.delayed(MetaballConfig.animationDuration, () {
        if (mounted) {
          widget.onClose();
        }
      });
    }
  }

  void _handleMenuItemTap(String item) {
    widget.onMenuItemTap?.call(item);
    // Don't auto-close for certain items like logout
    if (item.toLowerCase() != 'logout') {
      _closeMenu();
    }
  }
}











