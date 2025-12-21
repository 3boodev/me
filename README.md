# Digital Business Card Platform

A production-ready, scalable digital business card platform built with Flutter Web, following modern Flutter best practices. This application is designed for long-term maintainability, clean architecture, and effortless extensibility.

## 🚀 Features

- **Config-Driven Personal Profile**: All personal data loaded from a centralized config file
- **Extensible Social Platforms**: Data-driven social links that can be extended without UI changes
- **Multi-Language Support**: English (LTR) and Arabic (RTL) with automatic direction switching
- **Theme System**: Light/Dark mode with persistence
- **Responsive Design**: Optimized for desktop, tablet, and mobile
- **QR Code**: Quick access via QR code scanning
- **Web Share API**: Native sharing functionality
- **Clean Architecture**: Feature-first structure with clear separation of concerns

## 🏗 Architecture

The project follows a feature-first, scalable structure:

```
lib/
├─ core/                    # Core functionality shared across features
│  ├─ theme/               # Theme system with Riverpod
│  ├─ routing/             # go_router configuration
│  ├─ localization/        # intl-based localization
│  └─ utils/               # Utility functions (share, etc.)
├─ data/                   # Data layer
│  ├─ models/              # Data models
│  └─ config/              # Configuration files
├─ features/               # Feature modules
│  ├─ business_card/       # Main business card feature
│  │  ├─ presentation/     # UI pages/screens
│  │  ├─ providers/        # Riverpod providers
│  │  └─ widgets/          # Feature-specific widgets
│  └─ settings/            # Settings feature
│     ├─ presentation/
│     └─ providers/
└─ main.dart               # Application entry point
```

## 📦 Tech Stack

- **Flutter Web**: Cross-platform web framework
- **Riverpod**: State management
- **go_router**: Navigation and routing
- **font_awesome_flutter**: Social media icons
- **url_launcher**: External link handling
- **intl**: Localization
- **qr_flutter**: QR code generation
- **shared_preferences**: Theme and locale persistence

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Web browser for testing

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd business_card
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run -d chrome
```

4. Build for production:
```bash
flutter build web
```

## 📝 Configuration

### Personal Profile

Update your personal information in `lib/data/config/personal_config.dart`:

```dart
static const PersonalProfile profile = PersonalProfile(
  name: 'Your Name',
  jobTitle: 'Your Job Title',
  email: 'your.email@example.com',
  phone: '+1 (555) 123-4567',
  whatsapp: '+15551234567',  // Optional
  website: 'https://yourwebsite.com',  // Optional
);
```

### Adding Social Platforms

Social platforms are completely data-driven. To add a new platform, simply add an entry to the `platforms` list in `lib/data/config/personal_config.dart`:

```dart
SocialPlatform(
  id: 'your-platform-id',           // Unique identifier
  name: 'Platform Name',            // Display name
  icon: FontAwesomeIcons.iconName,  // FontAwesome icon
  url: 'https://your-profile-url',  // Profile URL
  brandColor: Color(0xFFHEXCODE),   // Brand color (hex)
),
```

**Example - Adding Instagram:**

```dart
SocialPlatform(
  id: 'instagram',
  name: 'Instagram',
  icon: FontAwesomeIcons.instagram,
  url: 'https://instagram.com/yourusername',
  brandColor: Color(0xFFE4405F),
),
```

**Available FontAwesome Icons:**
- `FontAwesomeIcons.linkedin`
- `FontAwesomeIcons.github`
- `FontAwesomeIcons.twitter`
- `FontAwesomeIcons.facebook`
- `FontAwesomeIcons.instagram`
- `FontAwesomeIcons.youtube`
- `FontAwesomeIcons.discord`
- `FontAwesomeIcons.telegram`
- And many more...

**No UI or logic changes required!** The platform will automatically appear in the social links section.

### Adding Languages

To add a new language:

1. **Add the locale** to `lib/core/localization/app_localizations.dart`:

```dart
class AppLocales {
  static const Locale english = Locale('en', 'US');
  static const Locale arabic = Locale('ar', 'SA');
  static const Locale spanish = Locale('es', 'ES');  // New language

  static const List<Locale> supportedLocales = [
    english,
    arabic,
    spanish,  // Add here
  ];
}
```

2. **Add translations** to the `_localizedValues` map:

```dart
static final Map<String, Map<String, String>> _localizedValues = {
  'en': { /* English translations */ },
  'ar': { /* Arabic translations */ },
  'es': {  // New language translations
    'app_title': 'Tarjeta de Negocios',
    'name': 'Nombre',
    'job_title': 'Título del Trabajo',
    // ... add all translation keys
  },
};
```

3. **Add language name** in `getLanguageName` method:

```dart
static String getLanguageName(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return 'English';
    case 'ar':
      return 'العربية';
    case 'es':
      return 'Español';  // Add here
    default:
      return locale.languageCode;
  }
}
```

4. **Add language option** in `lib/features/settings/presentation/settings_page.dart`:

```dart
_LanguageOption(
  title: 'Español',
  locale: AppLocales.spanish,
  currentLocale: locale,
  onChanged: (newLocale) {
    ref.read(localeProvider.notifier).setLocale(newLocale);
  },
),
```

The UI will automatically switch to RTL for RTL languages (like Arabic) and LTR for LTR languages.

### Adding Routes

To add a new route:

1. **Add route path** to `lib/core/routing/app_router.dart`:

```dart
class AppRoutes {
  static const String home = '/';
  static const String settings = '/settings';
  static const String about = '/about';  // New route
}
```

2. **Add route configuration** in the same file:

```dart
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      // ... existing routes
      GoRoute(
        path: AppRoutes.about,
        name: 'about',
        builder: (context, state) => const AboutPage(),  // Your page widget
      ),
    ],
  );
});
```

3. **Create the page** in the appropriate feature directory:

```dart
// lib/features/about/presentation/about_page.dart
class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Center(child: Text('About Page')),
    );
  }
}
```

4. **Navigate to the route**:

```dart
context.go(AppRoutes.about);
// or
context.push(AppRoutes.about);
```

## 🎨 Theming

The theme system is managed via Riverpod and persists user preferences.

### Theme Modes

- **Light Mode**: Clean, bright interface
- **Dark Mode**: Dark interface for low-light environments
- **System Mode**: Follows system preference

### Customizing Themes

Edit `lib/core/theme/app_theme.dart` to customize colors and styling:

```dart
// Light theme colors
static const Color lightPrimary = Color(0xFF6200EE);
static const Color lightSecondary = Color(0xFF03DAC6);
// ... customize as needed
```

## 🌍 Localization

The app supports multiple languages with RTL support. Current languages:

- **English** (en-US) - LTR
- **Arabic** (ar-SA) - RTL

### Translation Keys

All UI strings are localized. To add a new translation key:

1. Add the key to all language maps in `_localizedValues`
2. Add a getter in `AppLocalizations` class
3. Use it in your widgets: `localizations.yourKey`

## 📱 Responsive Design

The application automatically adapts to different screen sizes:

- **Desktop (>800px)**: Side-by-side layout with profile and QR code
- **Tablet/Mobile (<800px)**: Stacked vertical layout

## 🔗 Share Feature

The share feature uses the Web Share API when available, with clipboard fallback:

```dart
await ShareUtils.shareBusinessCard(
  url: 'https://yourwebsite.com',
  title: 'Your Name - Business Card',
  text: 'Your Name\nYour Job Title',
);
```

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📦 Building for Production

### Web

```bash
flutter build web --release
```

The output will be in `build/web/`. Deploy this directory to any static hosting service.

### Optimization Tips

- Enable tree-shaking: Already enabled by default
- Use `--web-renderer canvaskit` for better compatibility
- Consider code splitting for large applications

## 🏛 Project Structure Details

### Core Layer

- **Theme**: Centralized theme definitions and Riverpod providers
- **Routing**: go_router configuration and route definitions
- **Localization**: Translation system with RTL support
- **Utils**: Shared utilities (share, clipboard, etc.)

### Data Layer

- **Models**: Data structures (PersonalProfile, SocialPlatform)
- **Config**: Configuration files (personal data, platform definitions)

### Features Layer

Each feature is self-contained with:
- **Presentation**: UI pages and screens
- **Providers**: Riverpod state management
- **Widgets**: Reusable feature-specific components

## 🔧 Development Guidelines

1. **State Management**: Always use Riverpod providers for state
2. **Navigation**: Use go_router for all navigation
3. **Localization**: Never hard-code strings, always use localization
4. **Theming**: Use theme colors from `Theme.of(context)`
5. **Responsive**: Test on multiple screen sizes
6. **Accessibility**: Ensure proper contrast and icon sizing

## 📚 Additional Resources

- [Flutter Web Documentation](https://docs.flutter.dev/platform-integration/web)
- [Riverpod Documentation](https://riverpod.dev/)
- [go_router Documentation](https://pub.dev/packages/go_router)
- [Font Awesome Icons](https://fontawesome.com/icons)

## 🤝 Contributing

1. Follow the existing architecture patterns
2. Keep features self-contained
3. Add translations for all new UI strings
4. Test on multiple screen sizes
5. Ensure RTL support for new layouts

## 📄 License

[Your License Here]

## 👤 Author

[Your Name]

---

**Built with ❤️ using Flutter**
