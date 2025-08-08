import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';

class TemplateHorizontalSkeleton extends StatefulWidget {
  const TemplateHorizontalSkeleton({super.key});

  @override
  State<TemplateHorizontalSkeleton> createState() => _TemplateHorizontalSkeletonState();
}

class _TemplateHorizontalSkeletonState extends State<TemplateHorizontalSkeleton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.mailTemplateCardHeight,
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: context.paddingSM),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(context.paddingMD),
                      decoration: BoxDecoration(
                        color: AppColors.searchFill.withAlpha(
                          (255 * _fadeAnimation.value).round(),
                        ),
                        borderRadius: BorderRadius.circular(context.radiusMD),
                        border: Border.all(
                          color: AppColors.searchBorder.withAlpha(128),
                          width: context.borderWidthThin,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: context.iconSizeSM,
                            height: context.iconSizeSM,
                            decoration: BoxDecoration(
                              color: AppColors.textGrey.withAlpha(
                                (128 * _fadeAnimation.value).round(),
                              ),
                              borderRadius: BorderRadius.circular(context.borderRadiusSm),
                            ),
                          ),
                          SizedBox(width: context.spaceBtwItems),
                          Expanded(
                            child: Container(
                              height: context.mdV,
                              decoration: BoxDecoration(
                                color: AppColors.textGrey.withAlpha(
                                  (128 * _fadeAnimation.value).round(),
                                ),
                                borderRadius: BorderRadius.circular(context.borderRadiusSm),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: context.defaultSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: index == 0 ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.textGrey.withAlpha(102),
                borderRadius: BorderRadius.circular(context.borderRadiusSm),
              ),
            );
          }),
        ),
      ],
    );
  }
}
