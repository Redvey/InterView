import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEDE3FF), // Light lavender background
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
              children: races.map((race) => _buildChip(race, selectedRace, (val) {
                setState(() => selectedRace = val);
              })).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Gender", style: TextStyle(fontWeight: FontWeight.w600)),
            Wrap(
              spacing: 8,
              children: genders.map((gender) => _buildChip(gender, selectedGender, (val) {
                setState(() => selectedGender = val);
              })).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Pronoun", style: TextStyle(fontWeight: FontWeight.w600)),
            Wrap(
              spacing: 8,
              children: pronouns.map((pronoun) => _buildChip(pronoun, selectedPronoun, (val) {
                setState(() => selectedPronoun = val);
              })).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, String? selectedValue, Function(String) onSelected) {
    final bool isSelected = selectedValue == label;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(label),
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      selectedColor: Colors.black,
      backgroundColor: Colors.white,
      shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade400)),
    );
  }
}
