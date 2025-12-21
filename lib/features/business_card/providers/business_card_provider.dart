import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/config/personal_config.dart';
import '../../../../data/models/personal_profile.dart';
import '../../../../data/models/social_platform.dart';

/// Provider for personal profile data
/// 
/// This provider loads the personal profile from the centralized config.
final personalProfileProvider = Provider<PersonalProfile>((ref) {
  return PersonalConfig.profile;
});

/// Provider for social platforms list
/// 
/// This provider loads the social platforms from the centralized config.
/// The UI renders platforms dynamically based on this list.
final socialPlatformsProvider = Provider<List<SocialPlatform>>((ref) {
  return PersonalConfig.platforms;
});

