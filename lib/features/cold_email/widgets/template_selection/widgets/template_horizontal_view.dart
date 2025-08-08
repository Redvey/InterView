
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/cold_email/widgets/template_selection/widgets/template_chip.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/template_model.dart';


class TemplateHorizontalView extends StatefulWidget {
  final List<TemplateModel> templates;
  final String selectedTemplate;
  final Function(String) onTemplateChanged;

  const TemplateHorizontalView({
    super.key,
    required this.templates,
    required this.selectedTemplate,
    required this.onTemplateChanged,
  });

  @override
  State<TemplateHorizontalView> createState() => _TemplateHorizontalViewState();
}

class _TemplateHorizontalViewState extends State<TemplateHorizontalView> {
  late PageController _pageController;
  final int _templatesPerPage = 4;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int get _totalPages => (widget.templates.length / _templatesPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    if (widget.templates.isEmpty) {
      return _buildEmptyState(context);
    }

    return Column(
      children: [
        SizedBox(
          height: context.mailTemplateCardSpaceHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
              });
            },
            itemCount: _totalPages,
            itemBuilder: (context, pageIndex) {
              return _buildTemplatePage(pageIndex);
            },
          ),
        ),

        if (_totalPages > 1) ...[
          SizedBox(height: context.spaceBtwItemsH),
          _buildSmoothPageIndicator(),
        ],
      ],
    );
  }

  Widget _buildTemplatePage(int pageIndex) {
    final startIndex = pageIndex * _templatesPerPage;
    final endIndex = (startIndex + _templatesPerPage).clamp(0, widget.templates.length);
    final pageTemplates = widget.templates.sublist(startIndex, endIndex);

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
        itemCount: pageTemplates.length,
        itemBuilder: (context, index) {
          final template = pageTemplates[index];
          final isSelected = widget.selectedTemplate == template.id;

          return TemplateChip(
            template: template,
            isSelected: isSelected,
            onTap: () => widget.onTemplateChanged(template.id),
          );
        },
      ),
    );
  }

  Widget _buildSmoothPageIndicator() {
    return SmoothPageIndicator(
      controller: _pageController,
      count: _totalPages,
      effect: ExpandingDotsEffect(
        expansionFactor: 2.5,
        spacing: 8,
        radius: 4,
        dotHeight: 8,
        dotWidth: 8,
        dotColor: AppColors.textGrey.withAlpha(102),
        activeDotColor: AppColors.primary,
      ),
      onDotClicked: (index) {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
    );
  }


  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(context.paddingLG),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: context.iconSizeMD,
            color: AppColors.textGrey.withAlpha(128),
          ),
          SizedBox(height: context.spaceBtwItemsH),
          Text(
            'No templates available',
            style: context.hintTextGreyStyle.copyWith(
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
