import 'package:flutter/material.dart';
import 'package:interview/app/themes/fonts.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class QuestionPanel extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final String questionText;

  const QuestionPanel({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.questionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.paddingMD),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withAlpha(38), // 0.15 * 255 = 38.25 ≈ 38
            Colors.white.withAlpha(26), // 0.1 * 255 = 25.5 ≈ 26
          ],
        ),
        borderRadius: BorderRadius.circular(context.radiusLG),
        border: Border.all(
          color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
          width: context.borderWidthThin,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26), // 0.1 * 255 = 25.5 ≈ 26
            blurRadius: context.paddingXL,
            offset: Offset(0, context.sm),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.paddingMD,
                  vertical: context.paddingXS + context.radiusXS,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF64B5F6).withAlpha(204), // 0.8 * 255 = 204
                      const Color(0xFF42A5F5).withAlpha(204), // 0.8 * 255 = 204
                    ],
                  ),
                  borderRadius: BorderRadius.circular(context.md),
                  border: Border.all(
                    color: Colors.white.withAlpha(77), // 0.3 * 255 = 76.5 ≈ 77
                    width: context.borderWidthThin,
                  ),
                ),
                child: Text(
                  'Question $currentQuestion/$totalQuestions',
                  style: TextStyle(
                    fontSize: context.fontSizeSs,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  _buildActionButton(
                    context,
                    icon: Icons.replay,
                    onTap: () {
                      // Repeat question logic
                    },
                  ),
                  SizedBox(width: context.sm),
                  _buildActionButton(
                    context,
                    icon: Icons.skip_next,
                    onTap: () {
                      // Skip question logic
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: context.md),
          Text(
            questionText,
            style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: context.fontSizeSx,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.4,
            ),
          ),
          SizedBox(height: context.paddingMD),
          Container(
            width: double.infinity,
            height: context.xs,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
              borderRadius: BorderRadius.circular(context.radiusXS),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: currentQuestion / totalQuestions,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF64B5F6),
                      Color(0xFF42A5F5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(context.radiusXS),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(context.sm),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(26), // 0.1 * 255 = 25.5 ≈ 26
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
            width: context.borderWidthThin,
          ),
        ),
        child: Icon(
          icon,
          size: context.md,
          color: Colors.white.withAlpha(204), // 0.8 * 255 = 204
        ),
      ),
    );
  }
}