import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class CameraFeedWidget extends StatelessWidget {
  final int confidenceScore;
  final Animation<double> glowAnimation;

  const CameraFeedWidget({
    super.key,
    required this.confidenceScore,
    required this.glowAnimation,
  });

  Color _getConfidenceColor() {
    if (confidenceScore >= 80) return const Color(0xFF4CAF50);
    if (confidenceScore >= 60) return const Color(0xFF2196F3);
    if (confidenceScore >= 40) return const Color(0xFFFFC107);
    return const Color(0xFFFF5722);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowAnimation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( context.radiusLG ),
            boxShadow: [
              BoxShadow(
                color: _getConfidenceColor().withAlpha(77), // 0.3 * 255 = 76.5 ≈ 77
                blurRadius:  context.paddingXL  * glowAnimation.value,
                spreadRadius:  context.paddingXS  * glowAnimation.value,
              ),
              BoxShadow(
                color: Colors.black.withAlpha(51), // 0.2 * 255 = 51
                blurRadius:  context.spaceBtwItemsH  -  context.borderWidthThin ,
                offset: Offset(0,  context.sm ),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular( context.radiusLG ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey[900]!,
                    Colors.grey[800]!,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Camera placeholder
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.videocam,
                          size:  context.iconSize  +  context.iconSizeSM ,
                          color: Colors.white.withAlpha(138), // 0.54 * 255 = 137.7 ≈ 138
                        ),
                        SizedBox(height:  context.sm ),
                        Text(
                          'Camera Feed',
                          style: TextStyle(
                            color: Colors.white.withAlpha(138), // 0.54 * 255 = 137.7 ≈ 138
                            fontSize:  context.fontSizeSx ,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Face detection overlay
                  _buildFaceDetectionOverlay(context) ,

                  // Corner indicators
                  _buildCornerIndicators(context)  ,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFaceDetectionOverlay(BuildContext context) {
    return Positioned(
      top:  context.xl ,
      left:  context.xl ,
      right:  context.xl ,
      bottom:  context.lg ,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _getConfidenceColor(),
            width:  context.borderWidthDefault ,
          ),
          borderRadius: BorderRadius.circular( context.paddingMD ),
        ),
        child: Stack(
          children: [
            // Eye tracking dots
            Positioned(
              top:  context.spaceBtwItemsH  +  context.paddingXXL ,
              left:  context.spaceBtwItemsH  +  context.paddingXXL ,
              child: _buildEyeDot(context)  ,
            ),
            Positioned(
              top:  context.spaceBtwItemsH  +  context.paddingXXL ,
              right:  context.spaceBtwItemsH  +  context.paddingXXL ,
              child: _buildEyeDot(context)  ,
            ),

            // Confidence indicator
            Positioned(
              bottom:  context.spaceLessH ,
              left:  context.spaceLessH ,
              right:  context.spaceLessH ,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal:  context.sm ,
                    vertical:  context.xs 
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(179), // 0.7 * 255 = 178.5 ≈ 179
                  borderRadius: BorderRadius.circular( context.sm ),
                ),
                child: Text(
                  'Confidence: $confidenceScore%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _getConfidenceColor(),
                    fontSize:  context.fontSizeSs ,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEyeDot(BuildContext context) {
    return Container(
      width:  context.spaceLessH ,
      height:  context.spaceLessH ,
      decoration: BoxDecoration(
        color: _getConfidenceColor(),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _getConfidenceColor().withAlpha(128), // 0.5 * 255 = 127.5 ≈ 128
            blurRadius:  context.sm ,
            spreadRadius:  context.radiusXS ,
          ),
        ],
      ),
    );
  }

  Widget _buildCornerIndicators(BuildContext context) {
    return Stack(
      children: [
        // Top-left corner
        Positioned(
          top:  context.md ,
          left:  context.md ,
          child: _buildCornerIndicator(context)  ,
        ),
        // Top-right corner
        Positioned(
          top:  context.md ,
          right:  context.md ,
          child: _buildCornerIndicator(context)  ,
        ),
        // Bottom-left corner
        Positioned(
          bottom:  context.md ,
          left:  context.md ,
          child: _buildCornerIndicator(context)  ,
        ),
        // Bottom-right corner
        Positioned(
          bottom:  context.md ,
          right:  context.md ,
          child: _buildCornerIndicator(context)  ,
        ),
      ],
    );
  }

  Widget _buildCornerIndicator(BuildContext context) {
    return Container(
      width:  context.paddingXL ,
      height:  context.paddingXL ,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withAlpha(128), // 0.5 * 255 = 127.5 ≈ 128
          width:  context.borderWidthDefault ,
        ),
        borderRadius: BorderRadius.circular( context.xs ),
      ),
    );
  }
}