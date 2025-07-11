import 'package:flutter/material.dart';
import 'package:interview/core/constants/colors.dart';
import 'package:interview/features/resume/screens/widgets/selectable_controller.dart';
import 'package:interview/features/resume/screens/widgets/selectable_item_bottom_sheet.dart';
import 'package:interview/features/resume/screens/widgets/selectable_item_wrap.dart';

import 'data/roles_data.dart';

class OpenToRolesForm extends StatefulWidget {
  const OpenToRolesForm({super.key});

  @override
  State<OpenToRolesForm> createState() => _OpenToRolesFormState();
}

class _OpenToRolesFormState extends State<OpenToRolesForm> {
  final GenericSelectableController _controller = GenericSelectableController();

  void _showRolesBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SelectableItemBottomSheet(
        title: "Select Roles",
        categoryData: roleData,
        initiallySelected: _controller.selectedItems,
        maxSelection: 6,
        sheetColor: AppColors.rolesForm,
        onConfirm: (selected) {
          setState(() {
            _controller.setItems(selected);
          });
        },
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
            SelectableItemWrap(
              selectedItems: _controller.selectedItems,
              onDelete: (role) => _controller.removeItem(role, () => setState(() {})),
              onAdd: _showRolesBottomSheet,
              addLabel: " Add a Role",
            ),
          ],
        ),
      ),
    );
  }
}
