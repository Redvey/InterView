import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

class AchievementsForm extends StatefulWidget {
  const AchievementsForm({super.key});

  @override
  State<AchievementsForm> createState() => _AchievementsFormState();
}

class _AchievementsFormState extends State<AchievementsForm> {
  final List<TextEditingController> _achievementControllers = [];
  final List<bool> _confirmedAchievements = [];

  void _addAchievement() {
    setState(() {
      _achievementControllers.add(TextEditingController());
      _confirmedAchievements.add(false);
    });
  }

  void _removeAchievement(int index) {
    setState(() {
      _achievementControllers.removeAt(index);
      _confirmedAchievements.removeAt(index);
    });
  }

  void _toggleConfirmEdit(int index) {
    setState(() {
      _confirmedAchievements[index] = !_confirmedAchievements[index];
    });
  }

  @override
  void dispose() {
    for (var controller in _achievementControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.achievementsForm,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Achievements",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  ..._achievementControllers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final controller = entry.value;
                    final isConfirmed = _confirmedAchievements[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isConfirmed
                            ? const Color(0xFFFBF588) // Confirmed color
                            : const Color(0xFF6FECE2), // Default color
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              maxLines: null,
                              enabled: !isConfirmed,
                              decoration: const InputDecoration(
                                hintText: "Enter an achievement...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isConfirmed ? Icons.edit : Icons.check,
                              color: isConfirmed ? Colors.blue : Colors.green,
                            ),
                            onPressed: () => _toggleConfirmEdit(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeAchievement(index),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _addAchievement,
                    child: const DottedBorderContainer(label: "+ Add Achievement"),
                  ),
                ],
              ),
            ),
          ),
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
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
