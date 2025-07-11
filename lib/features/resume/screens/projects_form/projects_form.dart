import 'package:flutter/material.dart';
import 'package:interview/features/resume/screens/projects_form/widgets/add_project_sheet.dart';

import '../../../../core/constants/colors.dart';

class ProjectsForm extends StatefulWidget {
  const ProjectsForm({super.key});

  @override
  State<ProjectsForm> createState() => _ProjectsFormState();
}

class _ProjectsFormState extends State<ProjectsForm> {
  final List<Project> _projects = [];

  void _showAddProjectDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddProjectSheet(
        onAdd: (title, about, github, live) {
          setState(() {
            _projects.add(Project(
              title: title,
              about: about,
              githubLink: github,
              liveLink: live,
            ));
          });
        },
      ),
    );
  }


  void _removeProject(int index) {
    setState(() {
      _projects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.projectForm,
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
                  "Projects",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ..._projects.asMap().entries.map((entry) {
                  final i = entry.key;
                  final p = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1D6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(p.about),
                        const SizedBox(height: 8),
                        if (p.githubLink.isNotEmpty)
                          Text(
                            "GitHub: ${p.githubLink}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                            ),
                          ),
                        if (p.liveLink.isNotEmpty)
                          Text(
                            "Live: ${p.liveLink}",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.green,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.red,
                            ),
                            onPressed: () => _removeProject(i),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _showAddProjectDialog,
                  child: DottedBorderContainer(label: "+ Add Project"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Project {
  final String title;
  final String about;
  final String githubLink;
  final String liveLink;

  Project({
    required this.title,
    required this.about,
    required this.githubLink,
    required this.liveLink,
  });
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
