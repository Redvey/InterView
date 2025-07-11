import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/resume_form/widgets/dotted_button.dart';

class OpenToRolesForm extends StatefulWidget {
  const OpenToRolesForm({super.key});

  @override
  State<OpenToRolesForm> createState() => _OpenToRolesFormState();
}

class _OpenToRolesFormState extends State<OpenToRolesForm> {
  final List<String> _roles = [];
  final TextEditingController _roleController = TextEditingController();

  void _addRole(String role) {
    final trimmed = role.trim();
    if (trimmed.isEmpty || _roles.contains(trimmed)) return;
    setState(() => _roles.add(trimmed));
    _roleController.clear();
  }

  void _removeRole(String role) {
    setState(() => _roles.remove(role));
  }

  void _showAddRoleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a Role"),
        content: TextField(
          controller: _roleController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Enter a role (e.g. Flutter Dev)",
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            _addRole(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addRole(_roleController.text);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.rolesForm,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Open to Roles", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._roles.map((role) => Chip(
                  label: Text(role),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () => _removeRole(role),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )),
                GestureDetector(
                  onTap: _showAddRoleDialog,
                  child: const DottedBorderButton(detail: "Add a Role"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


