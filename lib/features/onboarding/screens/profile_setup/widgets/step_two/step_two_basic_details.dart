import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two/widgets/basic_details_dob.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two/widgets/basic_details_gender.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two/widgets/basic_details_header.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two/widgets/basic_details_location.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two/widgets/basic_details_privacy.dart';
import 'package:interview/features/onboarding/screens/profile_setup/widgets/step_two/widgets/basic_details_username.dart';
import '../../../../../../core/constants/strings.dart';


class StepTwoBasicDetails extends StatefulWidget {
  final Map<String, dynamic> initialData;
  final Function(Map<String, dynamic>) onDataChanged;

  const StepTwoBasicDetails({
    super.key,
    required this.initialData,
    required this.onDataChanged,
  });

  @override
  State<StepTwoBasicDetails> createState() => _StepTwoBasicDetailsState();
}

class _StepTwoBasicDetailsState extends State<StepTwoBasicDetails> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.initialData['username'] ?? '';
    _locationController.text = widget.initialData['location'] ?? '';
    _selectedGender = widget.initialData['gender'];
    _selectedDate = widget.initialData['dateOfBirth'];

    _usernameController.addListener(_updateData);
    _locationController.addListener(_updateData);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _updateData() {
    widget.onDataChanged({
      'username': _usernameController.text,
      'location': _locationController.text,
      'gender': _selectedGender,
      'dateOfBirth': _selectedDate,
    });
  }

  void _onGenderChanged(String? gender) {
    setState(() => _selectedGender = gender);
    _updateData();
  }

  void _onDateChanged(DateTime date) {
    setState(() => _selectedDate = date);
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.spaceBtwFields),
            const BasicDetailsHeader(),
            SizedBox(height: context.spaceBtwSections),
            BasicDetailsUsernameField(controller: _usernameController),
            SizedBox(height: context.spaceBtwFields),
            BasicDetailsGenderDropdown(
              selectedGender: _selectedGender,
              onChanged: _onGenderChanged,
              genderOptions: AppStrings.genderOptions,
            ),
            SizedBox(height: context.spaceBtwFields),
            BasicDetailsDobField(
              selectedDate: _selectedDate,
              onDateSelected: _onDateChanged,
            ),
            SizedBox(height: context.spaceBtwFields),
            BasicDetailsLocationField(controller: _locationController),
            SizedBox(height: context.spaceBtwSections),
            const BasicDetailsPrivacyNotice(),
          ],
        ),
      ),
    );
  }
}
