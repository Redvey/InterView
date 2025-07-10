import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class ProjectsForm extends StatefulWidget {
  const ProjectsForm({super.key});

  @override
  State<ProjectsForm> createState() => _ProjectsFormState();
}

class _ProjectsFormState extends State<ProjectsForm> {
  final List<Project> _projects = [];

  void _showAddProjectDialog() {
    final titleController = TextEditingController();
    final aboutController = TextEditingController();
    final githubController = TextEditingController();
    final liveController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Project"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Project Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: aboutController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "About the Project",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: githubController,
                decoration: const InputDecoration(
                  labelText: "GitHub Link",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: liveController,
                decoration: const InputDecoration(
                  labelText: "Live Link (optional)",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final project = Project(
                title: titleController.text.trim(),
                about: aboutController.text.trim(),
                githubLink: githubController.text.trim(),
                liveLink: liveController.text.trim(),
              );
              if (project.title.isNotEmpty && project.about.isNotEmpty) {
                setState(() {
                  _projects.add(project);
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
