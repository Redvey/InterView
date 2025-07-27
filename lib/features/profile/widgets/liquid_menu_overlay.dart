import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/image_strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../core/constants/strings.dart';
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
          // _buildProfileButton(),

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
              painter: MetaballShapesPainterV1(circles: _circles, metaBlur: context.metaBlur),
              size: Size.infinite,
            ),
          ),
        );
      },
    );
  }

  // Widget _buildProfileButton() {
  //   return Positioned(
  //     top: context.lgA,
  //     left: context.lg,
  //     child: GestureDetector(
  //       onTap: _openMenu,
  //       child: AnimatedContainer(
  //         duration: MetaballConfig.animationDuration,
  //         curve: Curves.easeInOut,
  //         height: context.profileHeight,
  //         width: context.profileWidth,
  //         transform: Matrix4.translationValues(
  //           _showMenu ? -context.profileTranslateX : context.zero,
  //           context.zero,
  //           context.zero,
  //         ),
  //
  //         decoration: const BoxDecoration(
  //           color: AppColors.blackLight,
  //           shape: BoxShape.circle,
  //         ),
  //         child: AnimatedOpacity(
  //           curve: Curves.easeOut,
  //           opacity: _showMenu ? 0.3 : 1.0,
  //           duration: MetaballConfig.animationDuration,
  //           child: Container(
  //             clipBehavior: Clip.none,
  //             // Add your profile content here if needed
  //             // For example: Icon, Image, etc.
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCloseButton() {
    return AnimatedPositioned(
      top: MediaQuery.of(context).padding.top + context.md,
      right: _showMenu ? context.md : -context.closeButtonHideOffset,
      duration: MetaballConfig.closeButtonAnimationDuration,
      child: GestureDetector(
        onTap: _closeMenu,
        child: Container(
          height: context.profileHeight,
          width: context.profileWidth,
          decoration: BoxDecoration(
            color: AppColors.backgroundWhite.withAlpha(
              context.closeButtonOpacity,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.close,
              color: AppColors.backgroundWhite,
              size: context.closeButtonIconSize,
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
            duration: Duration(
              milliseconds: context.userGreetingAnimationDuration,
            ),
            curve: Curves.easeInOut,
            transform: Matrix4.translationValues(
              _showMenu ? context.zero : -context.userGreetingTranslateX,
              context.zero,
              context.zero,
            ),
            child: Padding(
              padding: EdgeInsets.all(context.userGreetingPadding),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: context.userAvatarRadius,
                    backgroundImage: AssetImage(AppImage.pfp),
                  ),
                  SizedBox(height: context.md),
                  Text(
                    '${AppStrings.hi} ${widget.userName}..',
                    style: context.welcomeCardFinalStyle,
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
