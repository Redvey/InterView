import 'package:flutter/material.dart';
import 'package:interview/features/widgets/selectable_item_chip.dart';
import 'package:interview/features/resume/screens/widgets/model/selectable_item.dart';

class OtherInformationForm extends StatefulWidget {
  const OtherInformationForm({super.key});

  @override
  State<OtherInformationForm> createState() => _OtherInformationFormState();
}

class _OtherInformationFormState extends State<OtherInformationForm> {
  String? selectedRace;
  String? selectedGender;
  String? selectedPronoun;

  final List<String> races = [
    'Black/African-American',
    'East Asian',
    'Hispanic or Latino/a/x',
    'Middle Eastern',
    'Native American or Alaskan Native',
    'Pacific Islander',
    'South Asian',
    'Southeast Asian',
    'White',
    'Prefer not to say',
    'Others',
  ];

  final List<String> genders = ['Man', 'Woman', 'Others'];
  final List<String> pronouns = ['He/Him', 'She/Her', 'They/Them', 'Prefer not to say'];

  List<SelectableItem> _createSelectableItems(List<String> items, String? selectedValue) {
    return items.map((item) => SelectableItem(
      name: item,
      isSelected: selectedValue == item,
      icon: Icons.person_outline, // You can customize this icon per category
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEDE3FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Other Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text("Race", style: TextStyle(fontWeight: FontWeight.w600)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _createSelectableItems(races, selectedRace).map((item) {
                return SelectableItemChip.preference(
                  item: item,
                  selectedCount: selectedRace != null ? 1 : 0,
                  maxSelection: 1,
                  onToggle: (selectedItem) {
                    setState(() {
                      selectedRace = selectedRace == selectedItem.name ? null : selectedItem.name;
                    });
                  },
                  showIcon: false,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Gender", style: TextStyle(fontWeight: FontWeight.w600)),
            Wrap(
              spacing: 8,
              children: _createSelectableItems(genders, selectedGender).map((item) {
                return SelectableItemChip.preference(
                  item: item,
                  selectedCount: selectedGender != null ? 1 : 0,
                  maxSelection: 1,
                  onToggle: (selectedItem) {
                    setState(() {
                      selectedGender = selectedGender == selectedItem.name ? null : selectedItem.name;
                    });
                  },
                  showIcon: false,
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Pronoun", style: TextStyle(fontWeight: FontWeight.w600)),
            Wrap(
              spacing: 8,
              children: _createSelectableItems(pronouns, selectedPronoun).map((item) {
                return SelectableItemChip.preference(
                  item: item,
                  selectedCount: selectedPronoun != null ? 1 : 0,
                  maxSelection: 1,
                  onToggle: (selectedItem) {
                    setState(() {
                      selectedPronoun = selectedPronoun == selectedItem.name ? null : selectedItem.name;
                    });
                  },
                  showIcon: false,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}