import 'package:flutter/material.dart';

class SocialLinksForm extends StatefulWidget {
  const SocialLinksForm({super.key});

  @override
  State<SocialLinksForm> createState() => _SocialLinksFormState();
}

class _SocialLinksFormState extends State<SocialLinksForm> {
  final Map<String, TextEditingController> _controllers = {
    "Portfolio Website": TextEditingController(),
    "LinkedIn": TextEditingController(),
    "GitHub": TextEditingController(),
    "LeetCode": TextEditingController(),
  };

  final List<String> _customLinks = [];

  void _addCustomLink() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Social Platform"),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Platform name (e.g., Twitter)",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              if (name.isNotEmpty && !_controllers.containsKey(name)) {
                setState(() {
                  _customLinks.add(name);
                  _controllers[name] = TextEditingController();
                });
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _removeCustomLink(String name) {
    setState(() {
      _customLinks.remove(name);
      _controllers.remove(name);
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildTextField(String label, {bool removable = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
            if (removable)
              IconButton(
                icon: const Icon(Icons.close, size: 20, color: Colors.red),
                onPressed: () => _removeCustomLink(label),
              )
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _controllers[label],
          decoration: const InputDecoration(
            hintText: "Paste link",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final predefined = ["Portfolio Website", "LinkedIn", "GitHub", "LeetCode"];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Social Links", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Predefined Links
            ...predefined.map((label) => _buildTextField(label)),

            // Custom Added Links
            ..._customLinks.map((label) => _buildTextField(label, removable: true)),

            // Add Other Button
            GestureDetector(
              onTap: _addCustomLink,
              child: const DottedBorderContainer(label: "+ Add Other"),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedBorderContainer extends StatelessWidget {
  final String label;
  const DottedBorderContainer({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
