import 'package:flutter/material.dart';
import 'package:interview/app/themes/text_styles.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/extensions/responsive_extension.dart';

class SearchField extends StatefulWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final bool enabled;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  const SearchField({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.enabled = true,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius ,
    this.contentPadding,
    this.hintStyle,
    this.textStyle,
    this.suffixIcon,
    this.onTap,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _controller;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showClearButton = _controller.text.isNotEmpty;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
  }

  void _clearText() {
    _controller.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      enabled: widget.enabled,
      onTap: widget.onTap,
      onSubmitted: widget.onSubmitted,
      style: widget.textStyle,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? AppTextStyles.emptyStateHint(context),
        prefixIcon: Container(
          padding:  EdgeInsets.all(context.mx),
          child: Icon(Icons.search,size: context.iconSizeSm),
        ),
        suffixIcon: _showClearButton
            ? IconButton(
          icon:  Icon(Icons.clear,size: context.iconSizeSm, color: AppColors.bottomBlackLight),

          onPressed: _clearText,
        )
            : widget.suffixIcon,
        filled: true,
        fillColor: widget.fillColor ?? AppColors.buttonGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusLg),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.textGrey,
            width: context.borderWidthThin,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusLg),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.textGrey,
            width: context.borderWidthThin,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusLg),
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? AppColors.searchFocused,
            width: context.borderWidthDefault,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusLg),
          borderSide: BorderSide(
            color: AppColors.buttonTextGray,
            width: context.borderWidthThin,
          ),
        ),
        contentPadding: widget.contentPadding ??  EdgeInsets.symmetric(
          horizontal: context.md,
          vertical: context.mx,
        ),
      ),
    );
  }
}
