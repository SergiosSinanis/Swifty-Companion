import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/app_colors.dart';

class ProfileTab extends StatelessWidget {
  final UserProfile profile;

  const ProfileTab({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        children: [
        ClipOval( // make the image circular 120x120
            child: Container(
              width: 120,
              height: 120,
              color: Colors.white24,
              child: Image.network(
                profile.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 60, color: Colors.white54); // fallback if the user image fails
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            profile.login,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 24),
          _InfoRow(icon: Icons.email, label: 'Email', value: profile.email),
          _InfoRow(icon: Icons.phone, label: 'Phone', value: profile.phone ?? 'hidden'),
          _InfoRow(icon: Icons.trending_up, label: 'Level', value: profile.level.toStringAsFixed(2)),
          _InfoRow(icon: Icons.account_balance_wallet, label: 'Wallet', value: '${profile.wallet} ₳'),
        ],
      ),
    );
  }
}

// 1 row = icon + label on the left + value on the right
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.teal),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          const Spacer(),
          Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
