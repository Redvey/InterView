import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_one/utils/avatar_data.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_one/widgets/avatar_section.dart';
import 'widgets/profile_image_selector.dart';
import 'widgets/name_fields.dart';
import 'widgets/info_box.dart';

class StepOneProfilePicture extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final Function(Map<String, dynamic>) onDataChanged;
  final Function(bool)? onValidationChanged;

  const StepOneProfilePicture({
    super.key,
    required this.initialData,
    required this.onDataChanged,
    this.onValidationChanged,
  });

  @override
  State<StepOneProfilePicture> createState() => _StepOneProfilePictureState();
}

class _StepOneProfilePictureState extends State<StepOneProfilePicture> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  File? _profileImageFile;
  String? _profileImagePath;
  IconData? _selectedAvatarIcon;
  Color? _selectedAvatarBg;

  // Add this to track if validation should be shown
  bool _showValidationErrors = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.initialData['firstName'] ?? '';
    _lastNameController.text = widget.initialData['lastName'] ?? '';
    _profileImagePath = widget.initialData['profileImage'];

    _firstNameController.addListener(_onFormChanged);
    _lastNameController.addListener(_onFormChanged);

    // Always allow user to proceed initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onValidationChanged?.call(true);
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    _updateData();

    // If validation errors are being shown, revalidate in real-time
    if (_showValidationErrors) {
      _validateAndNotify();
    }
  }

  bool _validateAndNotify() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final firstNameValid = _firstNameController.text.trim().length >= 2;
    final lastNameValid = _lastNameController.text.trim().length >= 2;
    final formValid = isFormValid && firstNameValid && lastNameValid;

    final hasImage = _profileImageFile != null ||
        (_profileImagePath != null && _profileImagePath!.isNotEmpty) ||
        _selectedAvatarIcon != null;

    final isComplete = formValid && hasImage;
    widget.onValidationChanged?.call(isComplete);
    return isComplete;
  }

  // Add this method to trigger validation when Next is clicked
  bool validateStep() {
    setState(() {
      _showValidationErrors = true;
    });
    return _validateAndNotify();
  }

  void _updateData() {
    widget.onDataChanged({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'profileImage': _profileImageFile?.path ??
          _profileImagePath ??
          _selectedAvatarIcon?.codePoint.toString(),
    });
  }

  Future<void> _selectProfileImage() async {
    final picker = ImagePicker();

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Select from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final pickedFile = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImageFile = File(pickedFile.path);
          _selectedAvatarIcon = null;
        });
        _updateData();

        // If validation errors are being shown, revalidate
        if (_showValidationErrors) {
          _validateAndNotify();
        }
      }
    }
  }

  void _selectAvatar(AvatarData avatar) {
    setState(() {
      _selectedAvatarIcon = avatar.icon;
      _selectedAvatarBg = avatar.background;
      _profileImageFile = null;
    });
    _updateData();

    // If validation errors are being shown, revalidate
    if (_showValidationErrors) {
      _validateAndNotify();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: context.spaceBtwFields),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.stepOneTitle,
                style: context.headingStyle(color: AppColors.black87),
              ),
            ),
            SizedBox(height: context.sm),
            Text(
              AppStrings.stepOneSubtitle,
              style: context.subheadingStyle(color: AppColors.textGrey),
            ),

            SizedBox(height: context.spaceBtwSections),

            // Profile picture preview with validation error
            Column(
              children: [
                ProfileImageSelector(
                  profileImageFile: _profileImageFile,
                  profileImagePath: _profileImagePath,
                  avatarIcons: avatarList.map((a) => a.icon).toList(),
                  selectedAvatarIcon: _selectedAvatarIcon,
                  selectedAvatarBg: _selectedAvatarBg,
                  onChooseImage: _selectProfileImage,
                ),
                // Show error only when validation is triggered and no image is selected
                if (_showValidationErrors &&
                    _profileImageFile == null &&
                    (_profileImagePath == null || _profileImagePath!.isEmpty) &&
                    _selectedAvatarIcon == null)
                  Padding(
                    padding: EdgeInsets.only(top: context.xs),
                    child: Text(
                      'Please select a profile picture',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: context.spaceBtwFields),

            // Avatar choices
            AvatarSelector(
              avatars: avatarList,
              selectedPath: _selectedAvatarIcon?.codePoint.toString(),
              onSelectAvatar: _selectAvatar,
            ),

            SizedBox(height: context.spaceBtwFields),

            // Name fields
            NameFields(
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              showValidationErrors: _showValidationErrors,
            ),

            SizedBox(height: context.spaceBtwSections),

            // Info box
            const InfoBox(
              message: AppStrings.stepOneMessage,
            ),
          ],
        ),
      ),
    );
  }
}