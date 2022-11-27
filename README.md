# Introduction
This project was created with the aim to build main app of halo kak system.

# Getting Started
1. Please check [installation guide](https://docs.flutter.dev/get-started/install) to prepare your device for development.
2.	Clone/checkout the latest/main repository branch
3.	Navigate to project folder
4.	Run command 'flutter pub get'

# Build and Test

**Setup Configuration**
1. Duplicate and rename "key_config_example.dart" to "key_config.dart".
2. Put configuration/credential key inside the file.
3. Build

**Android/Web/Windows**

You can build directly after setup configuration.

**iOS/macOS**

1. Register your account on our app store connect development team
2. Generate development certificate in runner project file using XCode
3. Apply/select development certificate in runner project file using XCode
4. if you using macbook with processor M1 please enable rosetta in terminal
5. Run pod install on each folder (ios/macos)
6. Build

**Build configuration**

Build/launch app with **latest** configuration (**Default**):

```flutter run``` or ```flutter run --dart-define=ENVIRONMENT=LATEST```

Build/launch app with **staging** configuration:

```flutter run --dart-define=ENVIRONMENT=STAGING```

Build/launch app with **production** configuration:

```flutter run --dart-define=ENVIRONMENT=PROD```

# Release/Deployment
**Coming Soon**

# Contribute
Make sure to follow pull request flow in azure when develop new feature or setup. Feel free to contribute and check our todo list below.

Todo:
- [x] Setup State Management
- [x] Setup Assets Management
- [ ] Setup Style Management
    - [ ] Fonts
    - [ ] TextStyle
- [ ] Setup App icon
    - [ ] Android
    - [ ] Windows
    - [ ] Web
    - [ ] iOS
    - [ ] macOS
- [ ] Setup Splash screen
    - [ ] Android
    - [ ] iOS
- [x] Setup Secure Local Storage
    - [x] Android
    - [x] Windows
    - [x] Web
    - [x] iOS
    - [x] macOS
- [x] Setup Secure DB Storage
    - [x] Android
    - [x] Windows
    - [x] Web
    - [x] iOS
    - [x] macOS
- [x] Setup multiple configuration/environment
    - [x] Latest
    - [x] Staging
    - [x] Production
- [ ] Setup multiple flavor/instance build
    - [ ] Android
    - [ ] Windows
    - [ ] Web
    - [ ] iOS
    - [ ] macOS
- [ ] Setup Release/Deployment
    - [ ] Android
    - [ ] Windows
    - [ ] Web
    - [ ] iOS
    - [ ] macOS
- [ ] Setup text localizations

# Main Concepts/Approach

**State Management**

This project using [simple state management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple) by [provider](https://pub.dev/packages/provider) that recommended by flutter (21/10/2022).

**Assets Management**

This project using constants to maintain simplicity, consider using auto generated solution like [flutter gen](https://pub.dev/packages/flutter_gen) in the future.

**Build Management**

This project using environment singleton combine with args to control build (ex: flutter run --dart-define=ENVIRONMENT=STAGING). Consider implement flavor build in the future when [flutter flavoriz](https://pub.dev/packages/flutter_flavorizr) support desktop app (macOS/windows).

**Local key storage**

This project using [flutter secure storage](https://pub.dev/packages/flutter_secure_storage) to maintain credential securely and support any platform.

**Local DB storage**

This project using [hive](https://pub.dev/packages/hive) to maintain data securely and support any platform. Consider migrate to [isar](https://pub.dev/packages/isar) when [encrypted feature](https://github.com/isar/isar/issues/292) available or api already implement encrypted transaction.