import 'package:flutter/material.dart';
import 'dart:ui';


class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback? onTap;
  final bool isActive; // New parameter to handle active state
  final Color? activeBorderColor; // New parameter for active border color

  const GlassIconButton({
    super.key,
    required this.icon,
    this.size = 64,
    this.onTap,
    this.isActive = false,
    this.activeBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isActive
        ? (activeBorderColor ?? Colors.green)
        : Colors.white.withAlpha(128);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            width: isActive ? 3 : 2,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(200),
          color: Colors.white.withAlpha(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(25),
              offset: const Offset(0, 7.62),
              blurRadius: 22.85,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
            child: Container(
              color: Colors.black.withAlpha(0),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizActionButtons extends StatelessWidget {
  final bool showAnswer;
  final VoidCallback onToggleAnswer;
  final VoidCallback onMarkAsKnown;
  final VoidCallback onMarkAsUnknown;

  const QuizActionButtons({
    super.key,
    required this.showAnswer,
    required this.onToggleAnswer,
    required this.onMarkAsKnown,
    required this.onMarkAsUnknown,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 18,
      right: 18,
      height: 86,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GlassIconButton(
            icon: Icons.check,
            onTap: onMarkAsKnown,
          ),
          GlassIconButton(
            icon: showAnswer ? Icons.visibility_off : Icons.visibility,
            onTap: onToggleAnswer,
            isActive: showAnswer,
            activeBorderColor: Colors.green,
          ),
          GlassIconButton(
            icon: Icons.cancel_outlined,
            onTap: onMarkAsUnknown,
          ),
        ],
      ),
    );
  }
}