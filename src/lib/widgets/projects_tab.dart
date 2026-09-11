import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

class ProjectsTab extends StatelessWidget {
  final UserProfile profile;

  const ProjectsTab({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile.projects.isEmpty) {
      return const Center(
        child: Text('No projects yet.', style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    // this is called once per item = like loop
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      itemCount: profile.projects.length,
      itemBuilder: (context, index) {
        final project = profile.projects[index];
        final markText = project.finalMark != null ? '${project.finalMark}' : 'In progress';
        final markColor = project.finalMark == null
            ? AppColors.textSecondary // loading color (grey)
            : (project.finalMark! > 0 ? AppColors.teal : AppColors.coral);

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  project.name,
                  style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis, // treat overflowing long names with "..."
                ),
              ),
              const SizedBox(width: 12),
              Text(markText, style: TextStyle(color: markColor, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}
