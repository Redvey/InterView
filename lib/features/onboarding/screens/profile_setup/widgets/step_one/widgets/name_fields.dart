import 'package:flutter/material.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';

class NameFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final bool showValidationErrors; // Add this parameter

  const NameFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    this.showValidationErrors = false, // Default to false
  });

  InputDecoration _buildInputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    required BuildContext context,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: context.iconSizeMD),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(context.radiusMD),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Name
        TextFormField(
          controller: firstNameController,
          textCapitalization: TextCapitalization.words,
          decoration: _buildInputDecoration(
            label: 'First Name',
            hint: 'Enter your first name',
            icon: Icons.person_outline,
            context: context,
          ),
          validator: showValidationErrors ? (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your first name';
            }
            if (value!.trim().length < 2) {
              return 'First name must be at least 2 characters';
            }
            // Check for invalid characters
            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
              return 'First name should only contain letters';
            }
            return null;
          } : null, // Don't show validation until triggered
        ),

        SizedBox(height: context.spaceBtwFields),

        // Last Name
        TextFormField(
          controller: lastNameController,
          textCapitalization: TextCapitalization.words,
          decoration: _buildInputDecoration(
            label: 'Last Name',
            hint: 'Enter your last name',
            icon: Icons.person_outline,
            context: context,
          ),
          validator: showValidationErrors ? (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter your last name';
            }
            if (value!.trim().length < 2) {
              return 'Last name must be at least 2 characters';
            }
            // Check for invalid characters
            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
              return 'Last name should only contain letters';
            }
            return null;
          } : null, // Don't show validation until triggered
        ),
      ],
    );
  }
}