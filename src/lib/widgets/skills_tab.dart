import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

class SkillsTab extends StatelessWidget {
  final UserProfile profile;

  const SkillsTab({super.key, required this.profile});

  static const double _maxSkillLevelForDisplay = 20.0; // max skill (for percentage calculation)

  @override
  Widget build(BuildContext context) {
    if (profile.skills.isEmpty) {
      return const Center(
        child: Text('No skills yet.', style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    // this is called once per item = a like loop
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      itemCount: profile.skills.length,
      itemBuilder: (context, index) {
        final skill = profile.skills[index];
        final ratio = (skill.level / _maxSkillLevelForDisplay).clamp(0.0, 1.0);
        final percentText = '${(ratio * 100).toStringAsFixed(0)}%';

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      skill.name,
                      style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text('${skill.level.toStringAsFixed(2)}  ($percentText)', style: const TextStyle(color: AppColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: ratio,
                  minHeight: 8,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
