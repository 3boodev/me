import 'package:flutter/material.dart';

/// Model representing a social platform or contact method
/// 
/// This model is data-driven and extensible. To add a new platform,
/// simply add a new entry to the platforms list in the config file.
class SocialPlatform {
  final String id;
  final String name;
  final IconData icon;
  final String url;
  final Color brandColor;

  const SocialPlatform({
    required this.id,
    required this.name,
    required this.icon,
    required this.url,
    required this.brandColor,
  });

  /// Create a copy with updated fields
  SocialPlatform copyWith({
    String? id,
    String? name,
    IconData? icon,
    String? url,
    Color? brandColor,
  }) {
    return SocialPlatform(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      url: url ?? this.url,
      brandColor: brandColor ?? this.brandColor,
    );
  }

  /// Convert to JSON for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'brandColor': brandColor.value,
    };
  }
}

