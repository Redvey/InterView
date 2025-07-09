import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkExperienceForm extends StatefulWidget {
  const WorkExperienceForm({super.key});

  @override
  State<WorkExperienceForm> createState() => _WorkExperienceFormState();
}

class _WorkExperienceFormState extends State<WorkExperienceForm> {
  final List<ExperienceEntry> _experiences = [];

  void _addExperience() {
    setState(() {
      _experiences.add(ExperienceEntry());
    });
  }

  void _removeExperience(int index) {
    setState(() {
      _experiences.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Work Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          ..._experiences.asMap().entries.map((entry) {
            final index = entry.key;
            final experience = entry.value;
            return ExperienceCard(
              key: ValueKey(index),
              experience: experience,
              onRemove: () => _removeExperience(index),
            );
          }),

          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _addExperience,
            icon: const Icon(Icons.add),
            label: const Text("Add Experience"),
          ),
        ],
      ),
    );
  }
}

class ExperienceEntry {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  bool isCurrent = false;
}

class ExperienceCard extends StatefulWidget {
  final ExperienceEntry experience;
  final VoidCallback onRemove;

  const ExperienceCard({super.key, required this.experience, required this.onRemove});

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  final DateFormat formatter = DateFormat.yMMM();

  Future<void> _selectDate({required bool isFrom}) async {
    final initialDate = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          widget.experience.fromDate = picked;
        } else {
          widget.experience.toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD9F7ED),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TextField(
            controller: exp.jobTitleController,
            decoration: const InputDecoration(
              labelText: "Job Title",
              filled: true,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: exp.companyController,
            decoration: const InputDecoration(
              labelText: "Company",
              filled: true,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: exp.descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Description",
              filled: true,
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              const Text("From: "),
              TextButton.icon(
                onPressed: () => _selectDate(isFrom: true),
                icon: const Icon(Icons.calendar_today, size: 16),
                label: Text(exp.fromDate != null ? formatter.format(exp.fromDate!) : "Select"),
              ),
            ],
          ),

          Row(
            children: [
              const Text("Still Working here?"),
              Switch(
                value: exp.isCurrent,
                onChanged: (value) {
                  setState(() {
                    exp.isCurrent = value;
                    if (value) exp.toDate = null;
                  });
                },
              ),
            ],
          ),

          if (!exp.isCurrent)
            Row(
              children: [
                const Text("To: "),
                TextButton.icon(
                  onPressed: () => _selectDate(isFrom: false),
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: Text(exp.toDate != null ? formatter.format(exp.toDate!) : "Select"),
                ),
              ],
            ),

          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: widget.onRemove,
            icon: const Icon(Icons.delete, color: Colors.red),
            label: const Text("Remove this Experience", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
