import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
    child: Container(
    padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.contactForm,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Based Out Of
            const Text('Based Out Of'),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter your city or location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
        
            // Email
            const Text('Email'),
            const SizedBox(height: 8),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
        
            // Phone Number
            const Text('Phone Number'),
            const SizedBox(height: 8),
            const TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
