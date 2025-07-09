## 8.73.0 - 2024-01-XX (Refactoring Release)

### Breaking Changes
* Consolidated `notifi.dart` and `notifi2.dart` into a new modular architecture
* Changed from `ChangeNotifier` to Riverpod-based state management
* Moved platform-specific code to `PlatformHelper` utility class
* Restructured file organization with `core/` directory for main services

### New Features
* Added `NotificationService` - centralized notification management
* Added `CameraService` - dedicated camera functionality with Riverpod integration  
* Added `TopicManager` - improved FCM topic subscription management
* Added `NotificationHandler` - better message handling and routing
* Added centralized logging with `logger` utility
* Added helper functions for common operations (subscribe, show notifications, etc.)

### Improvements
* Better error handling throughout the library
* Consistent naming conventions
* Removed duplicate code between notifi.dart and notifi2.dart
* Improved type safety with code generation
* Better separation of concerns
* Added comprehensive migration guide

### Bug Fixes
* Fixed duplicate Firebase initialization
* Fixed global state anti-patterns
* Fixed async/void function declarations
* Removed commented-out code blocks

### Documentation
* Added MIGRATION_GUIDE.md for upgrading from previous versions
* Improved inline documentation
* Added examples for common use cases

## 8.72.0

* Previous release (before refactoring)
