import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/personal_profile.dart';
import '../models/social_platform.dart';

/// Centralized configuration for personal profile data
/// 
/// To update your personal information, modify the values in this file.
/// The UI will automatically reflect these changes.
class PersonalConfig {
  /// Personal profile information
  static const PersonalProfile profile = PersonalProfile(
    name: 'Abdullah Alamary',
    jobTitle: 'Senior Mobile Engineer',
    email: 'abdullah.alamary0@gmail.com',
    phone: '+20 (155) 225-2349',
    whatsapp: '+201552252349',
    website: 'https://3boodev.github.io/3boodeev/',
  );

  /// Social platforms and contact methods
  /// 
  /// To add a new platform:
  /// 1. Add a new SocialPlatform entry to this list
  /// 2. Use FontAwesome icons from font_awesome_flutter package
  /// 3. Provide a unique id, name, icon, url, and brandColor
  /// 
  /// Example:
  /// ```dart
  /// SocialPlatform(
  ///   id: 'linkedin',
  ///   name: 'LinkedIn',
  ///   icon: FontAwesomeIcons.linkedin,
  ///   url: 'https://linkedin.com/in/johndoe',
  ///   brandColor: Color(0xFF0077B5),
  /// ),
  /// ```
  static const List<SocialPlatform> platforms = [
    SocialPlatform(
      id: 'linkedin',
      name: 'LinkedIn',
      icon: FontAwesomeIcons.linkedin,
      url: 'https://www.linkedin.com/in/abdullah-alamary-8a5739140/',
      brandColor: Color(0xFF0077B5),
    ),
    SocialPlatform(
      id: 'github',
      name: 'GitHub',
      icon: FontAwesomeIcons.github,
      url: 'https://github.com/3boodev',
      brandColor: Color(0xFF181717),
    ),
    SocialPlatform(
      id: 'X',
      name: 'X',
      icon: FontAwesomeIcons.xTwitter,
      url: 'https://x.com/AbdullahAlamar0?t=saslo4jAis_ntvU51E7w5w&s=08',
      brandColor: Color(0xFF131313),
    ),
    SocialPlatform(
      id: 'email',
      name: 'Email',
      icon: FontAwesomeIcons.google,
      url: 'mailto:abdullah.alamary0@gmail.com',
      brandColor: Color(0xFFEA4335),
    ),
    SocialPlatform(
      id: 'whatsapp',
      name: 'WhatsApp',
      icon: FontAwesomeIcons.whatsapp,
      url: 'https://wa.me/+201552252349',
      brandColor: Color(0xFF25D366),
    ),
    SocialPlatform(
      id: 'website',
      name: 'Website',
      icon: FontAwesomeIcons.globe,
      url: 'https://3boodev.github.io/3boodeev/',
      brandColor: Color(0xFF4285F4),
    ),
  ];
}

