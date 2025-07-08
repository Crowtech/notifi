# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Notifi is a comprehensive Flutter library (v8.72.0) providing notification management, authentication, organization management, and geolocation services. It's published by Crowtech Pty Ltd and uses Flutter >=3.27.0 with Dart SDK >=3.6.0.

## Essential Development Commands

### Code Generation
Run after modifying models, repositories, or providers:
```bash
dart pub run build_runner build --delete-conflicting-outputs
```

### Common Flutter Commands
```bash
flutter pub get                    # Install dependencies
flutter analyze                    # Analyze code for issues
flutter test                       # Run all tests
flutter test test/specific_test.dart  # Run specific test file
flutter pub run flutter_launcher_icons  # Generate app icons
flutter pub run flutter_native_splash:create  # Generate splash screen
```

### Internationalization
The project uses `slang` for i18n. Translation files are in `lib/i18n/`. Configuration is in `slang.yaml`.

## Architecture & Code Organization

### Feature-First Architecture
The codebase follows a feature-first architecture pattern. Each feature module contains:
- `data/` - Repository implementations, API clients
- `domain/` - Business logic, entities, models (using Freezed)
- `presentation/` - UI components, screens, widgets

### Key Architectural Patterns

1. **Repository Pattern**: Each feature has a repository class for data operations
2. **Freezed Models**: Domain models use `@freezed` annotation for immutability
3. **Riverpod Providers**: State management uses `@riverpod` annotation with code generation
4. **JSON Serialization**: Models use `@JsonSerializable()` for API integration

### Directory Structure

- `lib/common_widgets/` - Reusable UI components (buttons, cards, dialogs)
- `lib/entities/` - Core domain entities shared across features
- `lib/features/` - Feature modules (each with data/domain/presentation)
- `lib/firebase/` - Firebase messaging and FCM integration
- `lib/geo/` - Geolocation, mapping, background location tracking
- `lib/i18n/` - Internationalization files and translations
- `lib/routing/` - GoRouter configuration and route definitions
- `lib/riverpod/` - Global providers and state management
- `lib/norganizations/`, `lib/persons/`, `lib/registrations/` - Main feature modules
- `parking/` - Experimental or deprecated features

### State Management

Uses Riverpod with these patterns:
- Feature-specific providers in each module
- Global providers in `lib/riverpod/`
- Generated providers using `@riverpod` annotation
- AsyncNotifierProvider for async operations
- StateProvider for simple state
- FutureProvider for one-time async data

### Routing

Uses GoRouter with typed routes:
- Route definitions in `lib/routing/`
- Routes use `@TypedGoRoute` for type safety
- Navigation through `context.go()` or `context.push()`

## Important Technical Details

### Local Path Dependencies
Several dependencies use local paths, indicating custom modifications:
- `oidc` - OIDC authentication
- `bdaya_shared_value` - Shared value utilities
- `status_alert` - Status alert UI

### Firebase Integration
- FCM for push notifications
- Topic-based messaging
- Background message handling
- Token management in `lib/firebase/`

### Geolocation Features
- Uses `flutter_background_geolocation` for background tracking
- Map integration with Flutter Map and OSM
- Geofencing capabilities
- Location permissions handling

### API Integration
- Uses Dio for HTTP requests
- Base URL and API configuration in `lib/api_utils.dart`
- JWT token authentication
- Interceptors for auth and error handling

### Code Generation Requirements
When modifying these file types, run code generation:
- `*.g.dart` - JSON serialization
- `*.freezed.dart` - Freezed models
- `*.gr.dart` - GoRouter routes
- `*_provider.dart` with `@riverpod` - Riverpod providers

### Platform-Specific Considerations
- Handles iOS, Android, and Web platforms
- Platform-specific implementations for notifications
- Different permission flows per platform
- Web limitations for background geolocation

## Testing Approach

Currently minimal test coverage. When adding tests:
- Place in `test/` mirroring `lib/` structure
- Use `mockito` for mocking dependencies
- Test repositories with mock Dio clients
- Test providers with ProviderContainer
- Focus on business logic in domain layer

## Common Development Tasks

### Adding a New Feature
1. Create feature directory under `lib/features/`
2. Add data/domain/presentation subdirectories
3. Create repository in data layer
4. Define models in domain with `@freezed`
5. Create providers with `@riverpod`
6. Build UI in presentation layer
7. Run code generation

### Modifying API Endpoints
1. Update repository methods in feature's data layer
2. Ensure proper error handling with Dio interceptors
3. Update corresponding models if response changes
4. Run code generation if models modified

### Adding Translations
1. Modify translation files in `lib/i18n/`
2. Follow existing key naming patterns
3. Ensure all languages are updated
4. The project supports GPT-4 translation assistance

### Working with Notifications
1. FCM configuration in `lib/firebase/`
2. Topic subscriptions managed per organization
3. Background handling requires platform-specific setup
4. Test with Firebase Console for push notifications