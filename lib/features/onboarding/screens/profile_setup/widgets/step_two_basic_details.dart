// step_two_basic_details.dart
import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import '../../../../../core/constants/colors.dart';

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

  final List<String> _genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];

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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blackLight,
              onPrimary: AppColors.white,
              surface: AppColors.white,
              onSurface: AppColors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _updateData();
    }
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: context.iconSizeMD),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: const BorderSide(color: AppColors.blackLight, width: 2),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
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

            // Header
            Text(
              'Basic Information',
              style: context.headingStyle(color: AppColors.black87),
            ),
            SizedBox(height: context.sm),
            Text(
              'Tell us a bit more about yourself',
              style: context.subheadingStyle(color: AppColors.textGrey),
            ),

            SizedBox(height: context.spaceBtwSections),

            // Username field
            TextFormField(
              controller: _usernameController,
              decoration: _buildInputDecoration(
                label: 'Username',
                hint: 'Choose a unique username',
                icon: Icons.alternate_email,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a username';
                }
                if (value!.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                  return 'Username can only contain letters, numbers, and underscores';
                }
                return null;
              },
            ),

            SizedBox(height: context.spaceBtwFields),

            // Gender dropdown
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: _buildInputDecoration(
                label: 'Gender',
                hint: 'Select your gender',
                icon: Icons.people_outline,
              ),
              items: _genderOptions.map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender, style: context.textFieldStyle),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
                _updateData();
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your gender';
                }
                return null;
              },
            ),

            SizedBox(height: context.spaceBtwFields),

            // Date of birth field
            GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: _buildInputDecoration(
                    label: 'Date of Birth',
                    hint: 'Select your date of birth',
                    icon: Icons.calendar_today_outlined,
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: context.iconSizeMD,
                    ),
                  ),
                  controller: TextEditingController(
                    text: _selectedDate != null ? _formatDate(_selectedDate!) : '',
                  ),
                  validator: (value) {
                    if (_selectedDate == null) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
              ),
            ),

            SizedBox(height: context.spaceBtwFields),

            // Location field
            TextFormField(
              controller: _locationController,
              textCapitalization: TextCapitalization.words,
              decoration: _buildInputDecoration(
                label: 'Location',
                hint: 'Enter your city, country',
                icon: Icons.location_on_outlined,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your location';
                }
                return null;
              },
            ),

            SizedBox(height: context.spaceBtwSections),

            // Privacy notice
            Container(
              padding: EdgeInsets.all(context.paddingMD),
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(context.radiusMD),
                border: Border.all(
                  color: AppColors.success,
                  width: context.borderWidthThin,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: AppColors.success,
                    size: context.iconSizeMD,
                  ),
                  SizedBox(width: context.sm),
                  Expanded(
                    child: Text(
                      'Your personal information is secure and will only be used to enhance your experience',
                      style: context.hintTextColorful(color: AppColors.darkGreen),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}