# cinemate_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── theme_constants.dart
│   ├── models/
│   │   ├── movie.dart
│   │   ├── movie.freezed.dart
│   │   ├── movie.g.dart
│   │   ├── user.dart
│   │   ├── user.freezed.dart
│   │   └── user.g.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   └── auth_service.dart
│   └── widgets/
│       ├── custom_app_bar.dart
│       └── custom_bottom_nav.dart
├── main.dart
├── modules/
│   ├── auth/
│   │   ├── screens/
│   │   │   ├── login/
│   │   │   │   ├── state.dart
│   │   │   │   └── view.dart
│   │   │   └── register/
│   │   │       ├── state.dart
│   │   │       └── view.dart
│   │   └── services/
│   │       └── auth_service.dart
│   ├── home/
│   │   ├── screens/
│   │   │   ├── home_screen/
│   │   │   │   ├── state.dart
│   │   │   │   └── view.dart
│   │   │   └── movie_details/
│   │   │       ├── state.dart
│   │   │       └── view.dart
│   │   └── services/
│   │       └── movie_service.dart
│   ├── profile/
│   │   ├── screens/
│   │   │   ├── profile_screen/
│   │   │   │   ├── state.dart
│   │   │   │   └── view.dart
│   │   │   └── edit_profile/
│   │   │       ├── state.dart
│   │   │       └── view.dart
│   │   └── services/
│   │       └── profile_service.dart
│   └── watchlist/
│       ├── screens/
│       │   ├── watchlist_screen/
│       │   │   ├── state.dart
│       │   │   └── view.dart
│       └── services/
│           └── watchlist_service.dart
