import 'package:flutter/material.dart';
import 'package:interview/app/themes/fonts.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../resume/screens/widgets/model/selectable_item.dart';

enum ChipVariant { primary, secondary, outlined, danger, success }
enum ChipSize { small, medium, large }

class SelectableItemChip extends StatelessWidget {
  final SelectableItem item;
  final int selectedCount;
  final int maxSelection;
  final Function(SelectableItem) onToggle;
  final ChipVariant variant;
  final ChipSize size;
  final bool showIcon;
  final bool showCheckmark;
  final EdgeInsetsGeometry? margin;
  final Duration animationDuration;

  const SelectableItemChip({
    super.key,
    required this.item,
    required this.selectedCount,
    required this.maxSelection,
    required this.onToggle,
    this.variant = ChipVariant.primary,
    this.size = ChipSize.medium,
    this.showIcon = true,
    this.showCheckmark = false,
    this.margin,
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = item.isSelected;
    final isDisabled = !isSelected && selectedCount >= maxSelection;

    final chipConfig = _chipConfig(context, isSelected);
    final colorConfig = _colorConfig(isSelected, isDisabled);

    return Container(
      margin: margin ?? EdgeInsets.only(right: context.sm, bottom: context.sm),
      child: ChoiceChip(
        label: Text(
          item.name,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            color: colorConfig.textColor,
            fontSize: chipConfig.fontSize,
            fontWeight: chipConfig.fontWeight,
          ),
        ),
        avatar: showIcon
            ? Icon(item.icon, size: chipConfig.iconSize, color: colorConfig.iconColor)
            : null,
        selected: isSelected,
        onSelected: (_) {
          if (!isSelected && selectedCount >= maxSelection) return;
          onToggle(item);
        },
        selectedColor: colorConfig.selectedColor,
        backgroundColor: colorConfig.backgroundColor,
        disabledColor: colorConfig.disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(chipConfig.borderRadius),
          side: BorderSide(color: colorConfig.borderColor, width: chipConfig.borderWidth),
        ),
        showCheckmark: showCheckmark,
        checkmarkColor: colorConfig.checkmarkColor,
        pressElevation: chipConfig.pressElevation,
        elevation: chipConfig.elevation,
        shadowColor: colorConfig.shadowColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  _ChipConfig _chipConfig(BuildContext context, bool isSelected) {
    switch (size) {
      case ChipSize.small:
        return _ChipConfig(14, 12, isSelected ? FontWeight.w500 : FontWeight.w400,
            context.radiusMD, 1.0, 0, 1);
      case ChipSize.medium:
        return _ChipConfig(18, 14, isSelected ? FontWeight.w600 : FontWeight.w400,
            context.radiusLG, 1.0, 0, 2);
      case ChipSize.large:
        return _ChipConfig(22, 16, isSelected ? FontWeight.w600 : FontWeight.w500,
            context.radiusXL, 1.5, 1, 3);
    }
  }

  _ColorConfig _colorConfig(bool isSelected, bool isDisabled) {
    final baseColors = {
      ChipVariant.primary: _VariantColors(
        selected: AppColors.blackLight,
        unselected: AppColors.white,
        textSelected: AppColors.white,
        textUnselected: AppColors.black,
        border: AppColors.grey300,
      ),
      // ChipVariant.secondary: _VariantColors(
      //   selected: AppColors.greyDark,
      //   unselected: AppColors.white,
      //   textSelected: AppColors.white,
      //   textUnselected: AppColors.textGrey,
      //   border: AppColors.greyDark,
      // ),
      // ChipVariant.outlined: _VariantColors(
      //   selected: AppColors.blackLight.withAlpha(26),
      //   unselected: Colors.transparent,
      //   textSelected: AppColors.blackLight,
      //   textUnselected: AppColors.textGrey,
      //   border: AppColors.blackLight,
      // ),
      // ChipVariant.success: _VariantColors(
      //   selected: AppColors.success,
      //   unselected: AppColors.successLight,
      //   textSelected: AppColors.white,
      //   textUnselected: AppColors.success,
      //   border: AppColors.success,
      // ),
      // ChipVariant.danger: _VariantColors(
      //   selected: AppColors.error,
      //   unselected: AppColors.errorLight,
      //   textSelected: AppColors.white,
      //   textUnselected: AppColors.error,
      //   border: AppColors.error,
      // ),
    };

    final c = baseColors[variant]!;

    return _ColorConfig(
      selectedColor: c.selected,
      backgroundColor: isDisabled ? AppColors.white : c.unselected,
      disabledColor: AppColors.white,
      textColor: isSelected
          ? c.textSelected
          : isDisabled
          ? AppColors.greyMedium
          : c.textUnselected,
      iconColor: isSelected
          ? c.textSelected
          : isDisabled
          ? AppColors.greyMedium
          : c.textUnselected,
      borderColor: isSelected
          ? c.border
          : isDisabled
          ? AppColors.grey300
          : c.border.withAlpha(180),
      checkmarkColor: c.textSelected,
      shadowColor: c.border.withAlpha(77),
    );
  }

  // Factory constructors for common patterns
  static SelectableItemChip skill({
    required SelectableItem item,
    required int selectedCount,
    required int maxSelection,
    required Function(SelectableItem) onToggle,
    bool showIcon = false,
  }) =>
      SelectableItemChip(
        item: item,
        selectedCount: selectedCount,
        maxSelection: maxSelection,
        onToggle: onToggle,
        variant: ChipVariant.primary,
        size: ChipSize.medium,
        showIcon: showIcon,
      );

  static SelectableItemChip preference({
    required SelectableItem item,
    required int selectedCount,
    required int maxSelection,
    required Function(SelectableItem) onToggle,
    bool showIcon = true,
  }) =>
      SelectableItemChip(
        item: item,
        selectedCount: selectedCount,
        maxSelection: maxSelection,
        onToggle: onToggle,
        variant: ChipVariant.primary,
        size: ChipSize.medium,
        showIcon: showIcon,
      );

  static SelectableItemChip filter({
    required SelectableItem item,
    required int selectedCount,
    required int maxSelection,
    required Function(SelectableItem) onToggle,
    bool showIcon = true,
    bool showCheckmark = false,
  }) =>
      SelectableItemChip(
        item: item,
        selectedCount: selectedCount,
        maxSelection: maxSelection,
        onToggle: onToggle,
        variant: ChipVariant.secondary,
        size: ChipSize.small,
        showIcon: showIcon,
        showCheckmark: showCheckmark,
      );

  static SelectableItemChip category({
    required SelectableItem item,
    required int selectedCount,
    required int maxSelection,
    required Function(SelectableItem) onToggle,
    ChipVariant variant = ChipVariant.success,
    bool showIcon = true,
  }) =>
      SelectableItemChip(
        item: item,
        selectedCount: selectedCount,
        maxSelection: maxSelection,
        onToggle: onToggle,
        variant: variant,
        size: ChipSize.large,
        showIcon: showIcon,
      );
}

class _ChipConfig {
  final double iconSize;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final double borderWidth;
  final double elevation;
  final double pressElevation;

  const _ChipConfig(
      this.iconSize,
      this.fontSize,
      this.fontWeight,
      this.borderRadius,
      this.borderWidth,
      this.elevation,
      this.pressElevation,
      );
}

class _ColorConfig {
  final Color selectedColor;
  final Color backgroundColor;
  final Color disabledColor;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;
  final Color checkmarkColor;
  final Color shadowColor;

  const _ColorConfig({
    required this.selectedColor,
    required this.backgroundColor,
    required this.disabledColor,
    required this.textColor,
    required this.iconColor,
    required this.borderColor,
    required this.checkmarkColor,
    required this.shadowColor,
  });
}

class _VariantColors {
  final Color selected;
  final Color unselected;
  final Color textSelected;
  final Color textUnselected;
  final Color border;

  const _VariantColors({
    required this.selected,
    required this.unselected,
    required this.textSelected,
    required this.textUnselected,
    required this.border,
  });
}
