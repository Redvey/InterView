import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/extensions/responsive_extension.dart';

class ResumeFormBottomButtons extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const ResumeFormBottomButtons({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all( context.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentPage > 0)
            GestureDetector(
              onTap: onPrevious,
              child: CircleAvatar(
                radius: 3,
                backgroundColor: AppColors.blackLight,
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.backgroundLightOrange,
                  size:  context.buttonHeight,
                ),
              ),
            ),
          GestureDetector(
            onTap: onNext,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.blackLight,
              child: Icon(
                currentPage == totalPages - 1 ? Icons.check : Icons.arrow_forward,
                color: AppColors.backgroundLime,
                size:  context.buttonHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
