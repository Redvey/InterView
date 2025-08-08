
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/features/cold_email/widgets/template_selection/widgets/template_horizontal_skeleton.dart';
import 'package:interview/features/cold_email/widgets/template_selection/widgets/template_horizontal_view.dart';
import 'models/template_model.dart';


class TemplateSelectionWidget extends StatefulWidget {
  final String selectedTemplate;
  final Function(String) onTemplateChanged;
  final VoidCallback onShowDrafts;
  final Future<List<TemplateModel>>? futureTemplates; // For backend integration
  final List<TemplateModel>? staticTemplates; // For static templates

  const TemplateSelectionWidget({
    super.key,
    required this.selectedTemplate,
    required this.onTemplateChanged,
    required this.onShowDrafts,
    this.futureTemplates,
    this.staticTemplates,
  });

  @override
  State<TemplateSelectionWidget> createState() => _TemplateSelectionWidgetState();
}

class _TemplateSelectionWidgetState extends State<TemplateSelectionWidget> {
  List<TemplateModel> _templates = [];

  // Default static templates
  static final List<TemplateModel> _defaultTemplates = [
    TemplateModel(
      id: 'informational',
      name: 'Informational',
      icon: Icons.info_outline,
      category: 'general',
    ),
    TemplateModel(
      id: 'jobApplication',
      name: 'Job Application',
      icon: Icons.work_outline,
      category: 'career',
    ),
    TemplateModel(
      id: 'networking',
      name: 'Networking',
      icon: Icons.people_outline,
      category: 'networking',
    ),
    TemplateModel(
      id: 'followUp',
      name: 'Follow Up',
      icon: Icons.follow_the_signs_outlined,
      category: 'follow-up',
    ),
    TemplateModel(
      id: 'inquiry',
      name: 'Job Inquiry',
      icon: Icons.email_outlined,
      category: 'inquiry',
    ),
    TemplateModel(
      id: 'business',
      name: 'Business',
      icon: Icons.business_outlined,
      category: 'business',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeTemplates();
  }

  void _initializeTemplates() {
    if (widget.staticTemplates != null) {
      _templates = widget.staticTemplates!;
    } else {
      _templates = _defaultTemplates;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.socialForm,
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(color: AppColors.blue800)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: context.spaceBtwFields),

          // Template horizontal view with backend support
          widget.futureTemplates != null
              ? _buildFutureTemplateView()
              : _buildStaticTemplateView(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.selectTemplate,
          style: context.sectionTitleStyle,
        ),
        TextButton.icon(
          onPressed: widget.onShowDrafts,
          icon: const Icon(
            Icons.drafts_outlined,
            color: AppColors.primary,
          ),
          label: Text(
            AppStrings.viewDrafts,
            style: context.buttonTextStyle.copyWith(
              color: AppColors.primary,
              fontSize: context.fontSizeSm,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFutureTemplateView() {
    return FutureBuilder<List<TemplateModel>>(
      future: widget.futureTemplates,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const TemplateHorizontalSkeleton();
        }

        if (snapshot.hasError) {
          return _buildErrorState();
        }

        final templates = snapshot.data ?? _defaultTemplates;

        return TemplateHorizontalView(
          templates: templates,
          selectedTemplate: widget.selectedTemplate,
          onTemplateChanged: widget.onTemplateChanged,
        );
      },
    );
  }

  Widget _buildStaticTemplateView() {
    return TemplateHorizontalView(
      templates: _templates,
      selectedTemplate: widget.selectedTemplate,
      onTemplateChanged: widget.onTemplateChanged,
    );
  }

  Widget _buildErrorState() {
    return Container(
      padding: EdgeInsets.all(context.paddingLG),
      decoration: BoxDecoration(
        color: AppColors.red.withAlpha(25),
        borderRadius: BorderRadius.circular(context.radiusMD),
        border: Border.all(
          color: AppColors.red.withAlpha(51),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.red,
            size: context.iconSizeMD,
          ),
          SizedBox(height: context.spaceBtwItems),
          Text(
            AppStrings.failedToLoadTemplates,
            style: context.bodyBoldStyle.copyWith(
              color: AppColors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.spaceBtwItemsH),
          Text(
            AppStrings.usingDefaultTemplates,
            style: context.hintTextGreyStyle.copyWith(
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}