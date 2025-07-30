import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class ControlButtons extends StatelessWidget {
  final bool isRecording;
  final Animation<double> pulseAnimation;
  final VoidCallback onToggleRecording;
  final VoidCallback onEndInterview;

  const ControlButtons({
    super.key,
    required this.isRecording,
    required this.pulseAnimation,
    required this.onToggleRecording,
    required this.onEndInterview,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: AnimatedBuilder(
            animation: pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: isRecording ? pulseAnimation.value : 1.0,
                child: GestureDetector(
                  onTap: onToggleRecording,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical:  context.md),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isRecording
                            ? [
                          const Color(0xFFFF6B6B),
                          const Color(0xFFFF5252),
                        ]
                            : [
                          const Color(0xFF4CAF50),
                          const Color(0xFF45A049),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular( context.md),
                      border: Border.all(
                        color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
                        width:  context.borderWidthThin,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (isRecording
                              ? const Color(0xFFFF6B6B)
                              : const Color(0xFF4CAF50))
                              .withAlpha(77), // 0.3 * 255 = 76.5 ≈ 77
                          blurRadius:  context.spaceBtwItemsH -  context.borderWidthThin,
                          offset: Offset(0,  context.xs),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isRecording ? Icons.stop : Icons.mic,
                          color: Colors.white,
                          size:  context.iconSizeSM,
                        ),
                        SizedBox(width:  context.sm),
                        Text(
                          isRecording ? 'Stop Recording' : 'Start Recording',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:  context.fontSizeSx,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width:  context.md),
        GestureDetector(
          onTap: onEndInterview,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal:  context.paddingXXL,
              vertical:  context.md,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha(51), // 0.2 * 255 = 51
                  Colors.white.withAlpha(26), // 0.1 * 255 = 25.5 ≈ 26
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular( context.md),
              border: Border.all(
                color: const Color(0xFFFF6B6B).withAlpha(128), // 0.5 * 255 = 127.5 ≈ 128
                width:  context.borderWidthDefault,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(26), // 0.1 * 255 = 25.5 ≈ 26
                  blurRadius:  context.spaceBtwItemsH -  context.borderWidthThin,
                  offset: Offset(0,  context.xs),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.stop_circle_outlined,
                  color: const Color(0xFFFF6B6B),
                  size:  context.paddingXL,
                ),
                SizedBox(height:  context.xs),
                Text(
                  'END',
                  style: TextStyle(
                    color: const Color(0xFFFF6B6B),
                    fontSize:  context.fontSizeSs,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}