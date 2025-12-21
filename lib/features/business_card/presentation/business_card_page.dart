import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/utils/share_utils.dart';
import '../../../data/config/personal_config.dart';
import '../widgets/profile_card.dart';
import '../widgets/qr_code_section.dart';
import '../widgets/social_links_section.dart';

/// Main business card page
/// 
/// This page displays the complete business card with profile information,
/// social links, and QR code. It includes a share button and settings button.
class BusinessCardPage extends ConsumerWidget {
  const BusinessCardPage({super.key});

  Future<void> _shareBusinessCard(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    final website = PersonalConfig.profile.website ?? '';
    final url = website.isNotEmpty ? website : 'https://example.com';
    
    await ShareUtils.shareBusinessCard(
      url: url,
      title: '${PersonalConfig.profile.name} - ${localizations.appTitle}',
      text: '${PersonalConfig.profile.name}\n${PersonalConfig.profile.jobTitle}',
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: localizations.share,
            onPressed: () => _shareBusinessCard(context),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: localizations.settings,
            onPressed: () => context.go(AppRoutes.settings),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          
          if (isWide) {
            // Desktop layout: side by side
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            ProfileCard(),
                            SocialLinksSection(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      const QrCodeSection(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Mobile/Tablet layout: stacked
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: const [
                  ProfileCard(),
                  SocialLinksSection(),
                  QrCodeSection(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

