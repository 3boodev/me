import 'package:business_card/features/business_card/widgets/animated_texts_componenets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/localization/app_localizations.dart';
import '../providers/business_card_provider.dart';

/// Widget displaying the main profile information card
/// 
/// This widget shows the user's name, job title, and contact information.
/// It's responsive and adapts to different screen sizes.
class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(personalProfileProvider);
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Profile Avatar
            // ClipOval(child: Image.asset('assets/images/profile.png',width: 100,height: 100,)),
            AnimatedImageContainer(
              width: 120,
              height: 140,
              image: 'assets/images/profile.png',
            ),
            const SizedBox(height: 22),

            // Name
            Text(
              profile.name,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Job Title
            Text(
              profile.jobTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),

            // Contact Information
            _ContactInfoItem(
              icon: Icons.email,
              label: localizations.email,
              value: profile.email,
              onTap: () => _launchEmail(profile.email),
            ),
            const SizedBox(height: 12),
            _ContactInfoItem(
              icon: Icons.phone,
              label: localizations.phone,
              value: profile.phone,
              onTap: () => _launchPhone(profile.phone),
            ),
            if (profile.website != null) ...[
              const SizedBox(height: 12),
              _ContactInfoItem(
                icon: Icons.language,
                label: localizations.website,
                value: profile.website!,
                onTap: () => _launchUrl(profile.website!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Contact information item widget
class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    textDirection: TextDirection.ltr,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

