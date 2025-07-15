import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';

import '../../../../core/constants/sizes.dart';
import 'package:blobs/blobs.dart';

class CircleEntryAnimation extends StatefulWidget {
  const CircleEntryAnimation({super.key});

  @override
  State<CircleEntryAnimation> createState() => _CircleEntryAnimationState();
}

class _CircleEntryAnimationState extends State<CircleEntryAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _topRightAnim;
  late final Animation<Offset> _topLeftAnim;
  late final Animation<Offset> _bottomLeftAnim;
  late final Animation<Offset> _aboveBottomRightAnim;
  late final Animation<Offset> _avatarContentExitAnim;
  late final Animation<Offset> _avatarCenterAnim;
  late final Animation<Offset> _iconEntryAnim;
  late final Animation<Offset> _textSlideAnim;
  late final Animation<double> _textOpacityAnim;
  late final Animation<double> _scaleAnim;

  bool _animationStarted = false;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
      reverseDuration: const Duration(milliseconds: 1500),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn,
    );
    _topLeftAnim = Tween<Offset>(
      begin: const Offset(-2, -2),
      end: Offset.zero,
    ).animate(curved);
    _topRightAnim = Tween<Offset>(
      begin: const Offset(2, -2),
      end: Offset.zero,
    ).animate(curved);
    _bottomLeftAnim = Tween<Offset>(
      begin: const Offset(-2, 2),
      end: Offset.zero,
    ).animate(curved);
    _aboveBottomRightAnim = Tween<Offset>(
      begin: const Offset(2, 1.3),
      end: Offset.zero,
    ).animate(curved);

    _avatarContentExitAnim = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(curved);
    _avatarCenterAnim = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.3, 0.4),
    ).animate(curved);


    _iconEntryAnim = Tween<Offset>(
      begin: const Offset(2, -1),
      end: Offset.zero,
    ).animate(curved);
    _textSlideAnim = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(curved);
    _textOpacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    _scaleAnim = Tween<double>(begin: 0.5, end: 5.0).animate(curved);

    // Start animation immediately
    _animationStarted = true;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedCircle(Animation<Offset> offsetAnim) {
    return SlideTransition(
      position: offsetAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Blob.fromID(
          id: ['13-3-59'],
          size: 500,
          styles: BlobStyles(
            color: AppColors.blackLight, // Use any color you want
          ),


        ),
      ),
      // ScaleTransition(
      //   scale: _scaleAnim,
      //   child: ClipOval(
      //     child: BackdropFilter(
      //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //       child: Container(
      //         width: 500,
      //         height: 500,
      //         decoration: BoxDecoration(
      //           color: AppColors.blackLight,
      //           shape: BoxShape.circle,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildAnimatedAvatar() {
    return SlideTransition(
      position: _avatarCenterAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    SlideTransition(
                      position: _avatarContentExitAnim,
                      child: Image.asset(
                        'assets/templates/template1.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Add a transparent overlay if you want to keep it interactive or blurred after exit
                    Container(color: AppColors.blackLight),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedText() {
    return FadeTransition(
      opacity: _textOpacityAnim,
      child: SlideTransition(
        position: _textSlideAnim,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.profile,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              AppStrings.settings,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(AppStrings.logOut, style: TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
        top: AppSizes.xl,
        left: AppSizes.lg,
        right: AppSizes.lg,
      ),

      child: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              if (_animationStarted)
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildAnimatedCircle(_topRightAnim),
                      _buildAnimatedCircle(_bottomLeftAnim),
                      _buildAnimatedCircle(_aboveBottomRightAnim),
                      _buildAnimatedCircle(_topLeftAnim),
                    ],
                  ),
                ),
              if (_animationStarted) Center(child: _buildAnimatedText()),
              Positioned(
                top: 0,
                left: 20,
                child: _buildAnimatedAvatar(), // No gesture here
              ),
              if (_animationStarted)
                Positioned(
                  top: 70,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      _controller.reverse().whenComplete(() {
                        if (context.canPop()) context.pop();
                      });
                    },
                    child: SlideTransition(
                      position: _iconEntryAnim,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColors.blackLight,
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}



