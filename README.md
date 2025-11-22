# 🔍 Lost & Found App

<div align="center">

![App Logo](assets/images/app_logo.png)

**A Modern Flutter Application for Finding Lost Items**

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-blue)](https://flutter.dev)

*Helping people reunite with their lost belongings through technology*

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Tech Stack](#-tech-stack) • [Contributing](#-contributing)

</div>

---

## 👨‍💻 Author

**Vijet Hegde**  
Pursuing BE in Computer Science and Design  
Dayananda Sagar Academy of Technology and Management (DSATM)

📧 Developer & Creator of this Lost & Found Application

---

## 📖 About the Project

The **Lost & Found App** is a modern, minimal mobile application built with Flutter that helps users report and find lost items efficiently. With a clean, intuitive interface inspired by Material Design 3 and Figma-style aesthetics, this app makes it easy for communities to help each other recover lost belongings.

### 🎯 Problem Statement

Every day, countless items are lost and found, but there's often no centralized platform to connect the two. This app bridges that gap by providing a simple, beautiful interface where users can:
- Report items they've lost
- Post items they've found
- Browse through lost and found items in their area
- Connect with others through contact information

---

## ✨ Features

### Core Functionality
- 🔐 **User Authentication** - Secure login and signup using Supabase
- 📝 **Create Posts** - Report lost or found items with detailed information
- 📸 **Image Upload** - Add photos of items for better identification
- 📍 **Location Tracking** - Specify where items were lost or found
- 📱 **Contact Information** - Share phone numbers for direct communication
- 🔍 **Browse Items** - View all lost and found items in organized feeds
- 🎨 **Modern UI** - Beautiful Material 3 design with animations

### UI/UX Highlights
- 🌟 **Splash Screen** - Animated gradient splash with clean branding
- 🎭 **Dark Mode Ready** - Supports system-wide theme preferences
- 🖼️ **Pinterest-Style Grid** - Masonry layout for item cards
- ✨ **Smooth Animations** - Flutter Animate for delightful interactions
- 📐 **Responsive Design** - Works seamlessly on mobile, tablet, and web
- 🎨 **Glassmorphism** - Modern glass effects on cards and overlays

### Technical Features
- 🔄 **State Management** - Riverpod for reactive state handling
- 🗄️ **Cloud Database** - Supabase for real-time data sync
- 🖼️ **Image Optimization** - Efficient image handling and caching
- 🌐 **Cross-Platform** - Runs on Android, iOS, and Web
- 📦 **Modular Architecture** - Clean, maintainable code structure

---

## 📱 Screenshots

| Splash Screen | Login Screen | Home Feed |
|:-------------:|:------------:|:---------:|
| ![Splash](screenshots/splash.png) | ![Login](screenshots/login.png) | ![Home](screenshots/home.png) |

| Lost Items | Found Items | Add Item |
|:----------:|:-----------:|:--------:|
| ![Lost](screenshots/lost.png) | ![Found](screenshots/found.png) | ![Add](screenshots/add.png) |

| Item Details | Profile | Dark Mode |
|:------------:|:-------:|:---------:|
| ![Details](screenshots/details.png) | ![Profile](screenshots/profile.png) | ![Dark](screenshots/dark.png) |

*Note: Screenshots to be added*

---

## 🛠️ Tech Stack

### Frontend
- **Flutter** - UI framework for building natively compiled applications
- **Dart** - Programming language optimized for UI development
- **Material 3** - Latest Material Design components and theming

### State Management
- **Riverpod** - Reactive state management and dependency injection

### Backend & Services
- **Supabase** - Backend-as-a-Service (BaaS)
  - Authentication
  - PostgreSQL Database
  - Storage for images
  - Real-time subscriptions

### Key Packages
```yaml
Dependencies:
  - flutter_riverpod: ^2.5.0           # State management
  - supabase_flutter: ^2.10.3          # Backend services
  - image_picker: ^1.0.7               # Image selection
  - cached_network_image: ^3.3.1       # Image caching
  - flutter_animate: ^4.5.0            # Smooth animations
  - google_fonts: ^6.1.0               # Custom typography
  - flutter_staggered_grid_view: ^0.7.0 # Masonry grid
  - intl: ^0.19.0                      # Date formatting
  - url_launcher: ^6.3.0               # External links
```

---

## 📁 Project Structure

```
Flutter LOFO app/
├── assets/
│   └── images/
│       ├── app_logo.png              # App logo
│       ├── splash_logo.png           # Splash screen logo
│       └── splash_background.png     # Splash gradient background
│
├── lib/
│   ├── main.dart                     # App entry point
│   │
│   ├── models/
│   │   ├── item_model.dart          # Item data model
│   │   └── user_model.dart          # User data model
│   │
│   ├── providers/
│   │   ├── auth_provider.dart       # Authentication state
│   │   └── item_provider.dart       # Items state management
│   │
│   ├── services/
│   │   ├── auth_service.dart        # Auth operations
│   │   ├── item_service.dart        # CRUD operations
│   │   └── storage_service.dart     # Image upload/download
│   │
│   ├── supabase/
│   │   └── supabase_config.dart     # Supabase initialization
│   │
│   └── ui/
│       ├── screens/
│       │   ├── splash/
│       │   │   └── splash_screen.dart
│       │   ├── auth/
│       │   │   ├── modern_login_screen.dart
│       │   │   └── modern_signup_screen.dart
│       │   ├── home/
│       │   │   ├── modern_home_screen.dart
│       │   │   ├── modern_lost_items_screen.dart
│       │   │   ├── modern_found_items_screen.dart
│       │   │   ├── modern_add_item_screen.dart
│       │   │   └── modern_profile_screen.dart
│       │   └── item_details/
│       │       └── modern_item_details_screen.dart
│       │
│       ├── theme/
│       │   └── app_theme.dart       # Theme configuration
│       │
│       └── widgets/
│           ├── modern_widgets.dart   # Reusable widgets
│           ├── modern_item_card.dart # Item card component
│           └── shimmer_widgets.dart  # Loading skeletons
│
├── android/                          # Android-specific code
├── ios/                              # iOS-specific code
├── web/                              # Web-specific code
├── pubspec.yaml                      # Dependencies
└── README.md                         # This file
```

---

## 🚀 Installation

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Android SDK (for Android development)
- Xcode (for iOS development - macOS only)

### Setup Instructions

#### 1️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/flutter-lofo-app.git
cd flutter-lofo-app
```

#### 2️⃣ Install Dependencies
```bash
flutter pub get
```

#### 3️⃣ Configure Supabase

Create a `.env` file in the root directory (copy from `.env.example`):

```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

Update `lib/supabase/supabase_config.dart` with your Supabase credentials.

#### 4️⃣ Run the App

**On Android Device/Emulator:**
```bash
flutter run
```

**On Web:**
```bash
flutter run -d chrome
```

**On Specific Device:**
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

#### 5️⃣ Build for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**Web:**
```bash
flutter build web --release
```

---

## 🗄️ Database Schema

### Items Table
```sql
CREATE TABLE items (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id),
  type VARCHAR(10) CHECK (type IN ('lost', 'found')),
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR(255) NOT NULL,
  contact VARCHAR(20) NOT NULL,
  image_url TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Users Table (Handled by Supabase Auth)
- Authentication managed by Supabase
- User profiles stored in `auth.users`

---

## 🎨 Design System

### Color Palette
```dart
Primary Purple: #6A5AE0
Secondary Pink:  #B96AD9
Lost Item Red:   #FF6B6B
Found Item Green: #51CF66
Background:      #F8F9FA
Card Background: #FFFFFF
```

### Typography
- **Font Family**: Google Fonts (Inter, Poppins)
- **Headings**: Bold, 24-32px
- **Body**: Regular, 14-16px
- **Captions**: Medium, 12-14px

### Spacing
- Small: 8px
- Medium: 16px
- Large: 24px
- XLarge: 32px

---

## 🖥️ Supported Platforms

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Fully Supported | Tested on Android 12+ |
| iOS | ✅ Supported | Requires macOS for development |
| Web | ✅ Fully Supported | Chrome, Firefox, Safari |
| Windows | 🔄 In Progress | Desktop support coming soon |
| macOS | 🔄 In Progress | Desktop support coming soon |
| Linux | 🔄 In Progress | Desktop support coming soon |

---

## 📋 Screens Overview

1. **Splash Screen** - Animated logo with gradient background
2. **Login Screen** - Email/password authentication with glassmorphism
3. **Signup Screen** - User registration with validation
4. **Home Screen** - Bottom navigation with tabs
5. **Lost Items Feed** - Pinterest-style masonry grid
6. **Found Items Feed** - Matching grid layout
7. **Add Item Screen** - Form with image upload
8. **Item Details** - Full-screen item view with actions
9. **Profile Screen** - User information and settings

---

## 🔮 Future Enhancements

### Planned Features
- [ ] 🗺️ **Map Integration** - View items on Google Maps
- [ ] 🔔 **Push Notifications** - Get alerts for new lost/found items
- [ ] 💬 **In-app Chat** - Direct messaging between users
- [ ] 🔎 **Advanced Search** - Filter by category, date, location
- [ ] 📊 **Analytics Dashboard** - Track your posts and views
- [ ] 🌍 **Multi-language Support** - Internationalization (i18n)
- [ ] 🏆 **Gamification** - Rewards for helping others
- [ ] 🤖 **AI Image Recognition** - Auto-tag items from photos
- [ ] ⭐ **Rating System** - Rate helpful finders
- [ ] 📱 **QR Code Scanner** - Quick item lookup

### Technical Improvements
- [ ] Offline mode with local caching
- [ ] Performance optimization
- [ ] Unit and integration tests
- [ ] CI/CD pipeline setup
- [ ] Error tracking and analytics

---

## 🧪 Testing

### Run Tests
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/models/item_model_test.dart
```

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Contribution Guidelines
- Follow Flutter style guide
- Write clear commit messages
- Add tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing framework
- **Supabase** - For backend infrastructure
- **Material Design** - For design inspiration
- **DSATM** - Dayananda Sagar Academy of Technology and Management
- **Open Source Community** - For valuable packages and resources

---

## 📞 Contact & Support

**Developer:** Vijet Hegde  
**Institution:** DSATM - BE Computer Science  
**Project Type:** Academic / Portfolio Project

### Get in Touch
- 📧 Email: [your-email@example.com]
- 💼 LinkedIn: [Your LinkedIn Profile]
- 🐙 GitHub: [@yourusername]

### Report Issues
Found a bug? Have a suggestion? Please [open an issue](https://github.com/yourusername/flutter-lofo-app/issues)

---

## 📊 Project Stats

![GitHub stars](https://img.shields.io/github/stars/yourusername/flutter-lofo-app?style=social)
![GitHub forks](https://img.shields.io/github/forks/yourusername/flutter-lofo-app?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/yourusername/flutter-lofo-app?style=social)

---

<div align="center">

### ⭐ If you found this project helpful, please give it a star!

**Made with ❤️ using Flutter**

</div>

---

## 📚 Additional Documentation

- [Supabase Migration Guide](SUPABASE_MIGRATION_GUIDE.md)
- [UI Redesign Documentation](UI_REDESIGN_COMPLETE.md)
- [Setup Checklist](SETUP_CHECKLIST.md)
- [Quick Start Guide](QUICK_START.md)
- [Logo Integration](LOGO_INTEGRATION_COMPLETE.md)
- [Splash Screen Update](SPLASH_SCREEN_UPDATE_COMPLETE.md)

---

## 💡 Tips for Users

1. **Clear Photos** - Use well-lit, clear photos for better identification
2. **Detailed Descriptions** - Include unique identifying features
3. **Accurate Location** - Be specific about where items were lost/found
4. **Valid Contact** - Ensure your phone number is correct
5. **Check Regularly** - New items are posted frequently

---

<div align="center">

**Happy Finding! 🔍**

*Developed as part of BE Computer Science curriculum at DSATM*

</div>
