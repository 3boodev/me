/// Model representing personal profile information
/// 
/// This model holds all personal data that is displayed on the business card.
/// The data is loaded from a centralized config file.
class PersonalProfile {
  final String name;
  final String jobTitle;
  final String email;
  final String phone;
  final String? whatsapp;
  final String? website;
  final String? websiteTitle;

  const PersonalProfile({
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.phone,
    this.whatsapp,
    this.website,
    this.websiteTitle,
  });

  /// Create a copy with updated fields
  PersonalProfile copyWith({
    String? name,
    String? jobTitle,
    String? email,
    String? phone,
    String? whatsapp,
    String? website,
    String? websiteTitle,
  }) {
    return PersonalProfile(
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      website: website ?? this.website,
      websiteTitle: websiteTitle ?? this.websiteTitle,
    );
  }
}

