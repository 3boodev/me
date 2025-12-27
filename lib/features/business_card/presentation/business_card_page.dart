import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/share_utils.dart';
import '../../../data/config/personal_config.dart';
import '../widgets/profile_card.dart';
import '../widgets/qr_code_section.dart';
import '../widgets/social_links_section.dart';
import '../../../../core/responsive/responsive_layout.dart';

/// Main business card page
/// 
/// This page displays the complete business card with profile information,
/// social links, and QR code. It includes a share button and settings button.
class BusinessCardPage extends ConsumerWidget {
  const BusinessCardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ResponsiveLayout(
      mobile: _MobileLayout(),
      tablet: _TabletLayout(),
      desktop: _DesktopLayout(),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          ProfileCard(),
          SizedBox(height: 24),
          SocialLinksSection(),
          SizedBox(height: 32),
          QrCodeSection(),
          SizedBox(height: 48), // Bottom spacing for safe area/browser UI
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  const _TabletLayout();

  @override
  Widget build(BuildContext context) {
    // Tablet layout (600-1024px)
    // We try to maintain a balanced view, similar to desktop but maybe more fluid
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: const [
                  ProfileCard(),
                  SizedBox(height: 24),
                  SocialLinksSection(),
                ],
              ),
            ),
            const SizedBox(width: 24),
            const Expanded(
              flex: 2,
              child: QrCodeSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
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
              const SizedBox(width: 32),
              const QrCodeSection(),
            ],
          ),
        ),
      ),
    );
  }
}
