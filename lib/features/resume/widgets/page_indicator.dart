import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.pageController,
    required this.totalPages,
    required this.activeDotColor,
  });

  final PageController pageController;
  final int totalPages;
  final Color activeDotColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: pageController,
        count: totalPages,
        effect: ExpandingDotsEffect(
          radius: 7,
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: activeDotColor,
          dotColor: activeDotColor.withAlpha((0.3 * 255).round()),
        ),
        onDotClicked: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
