# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Notifi is a comprehensive Flutter library (v8.72.0) developed by Crowtech Pty Ltd that provides shared functionality for the Panta ecosystem. It serves as a foundation package for Flutter applications requiring notification management, authentication, organization structures, and location-based services.

## Key Commands

### Code Generation (Required after model/provider changes)
```bash
# Generate all .g.dart files (Freezed, JsonSerializable, Riverpod)
./generate_g_dart.sh

# Or manually:
dart pub run build_runner build --delete-conflicting-outputs

# Generate translations (requires API key)
./generate_translations.sh [language_code]
```

### Package Management
```bash
# Get dependencies
flutter pub get


# Upgrade dependencies
flutter pub upgrade

# Clean and get dependencies
flutter clean && flutter pub get
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/[path_to_test].dart

# Run tests with coverage
flutter test --coverage
```

### Development
```bash
# Analyze code
flutter analyze

# Format code
dart format .

# Check for dependency issues
flutter pub deps
```

## Architecture Overview

### Feature-First Architecture
Each feature module follows a consistent structure:
- `data/` - Data sources, repositories, DTOs
- `domain/` - Business logic, entities, use cases
- `presentation/` - UI components, controllers, state

### Core Features
1. **Notification Management** (`lib/features/notification/`)
   - Firebase Cloud Messaging integration
   - Topic-based notifications
   - Local notifications with scheduling
   - Background notification handling

2. **Authentication** (`lib/features/auth/`)
   - OIDC/OAuth2 with Keycloak
   - Token management and refresh
   - Multi-realm support
   - Biometric authentication

3. **Organization Management** (`lib/features/organization/`)
   - Multi-tenant organization structure
   - Role-based access control
   - Organization switching

4. **Geolocation Services** (`lib/features/geolocation/`)
   - Background location tracking
   - Geofencing capabilities
   - Location permissions handling
   - Map integration with Flutter Map

5. **Rich Content** (`lib/features/rich_text/`)
   - Quill editor integration
   - Rich text formatting
   - Document persistence

### State Management
- **Riverpod** for all state management
- Code generation with `@riverpod` annotations
- Providers in `lib/providers/` directory
- Feature-specific providers within feature modules

### Platform Support
- iOS, Android, and Web platforms
- Platform-specific implementations in `lib/services/platform/`
- Conditional imports for web compatibility

## Key Dependencies

### State & Architecture
- `flutter_riverpod`: State management
- `freezed`: Immutable data classes
- `json_serializable`: JSON serialization
- `go_router`: Navigation

### Backend Integration
- `dio`: HTTP client
- `retrofit`: REST API client
- `openid_client`: OIDC authentication
- `minio_new`: Object storage

### UI & UX
- `flutter_map`: OpenStreetMap integration
- `flutter_quill`: Rich text editing
- `slang`: Internationalization
- `adaptive_breakpoints`: Responsive design

### Device Features
- `firebase_messaging`: Push notifications
- `flutter_background_geolocation`: Location tracking
- `image_picker`: Camera/gallery access
- `permission_handler`: Permission management

## Development Patterns

### Code Generation Requirements
Always run `./generate_g_dart.sh` after modifying:
- Models with `@freezed` or `@JsonSerializable`
- Providers with `@riverpod` annotations
- Retrofit API interfaces with `@RestApi`

### Error Handling
- Custom exceptions in `lib/core/errors/`
- Either type for functional error handling
- Consistent error messaging through providers

### Service Layer
- Abstract service interfaces in `lib/services/`
- Platform-specific implementations
- Dependency injection through Riverpod

### Testing Strategy
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for feature flows
- Mock services for testing

## Common Patterns

### Provider Patterns
```dart
// Feature provider with code generation
@riverpod
class FeatureName extends _$FeatureName {
  @override
  FeatureState build() => FeatureState.initial();
  
  // Methods for state manipulation
}
```

### Model Patterns
```dart
// Freezed model with JSON serialization
@freezed
class ModelName with _$ModelName {
  const factory ModelName({
    required String id,
    @Default([]) List<Item> items,
  }) = _ModelName;
  
  factory ModelName.fromJson(Map<String, dynamic> json) =>
      _$ModelNameFromJson(json);
}
```

### Service Integration
```dart
// Retrofit API client
@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;
  
  @GET('/endpoint')
  Future<Response> getData();
}
```

## Platform Considerations

### Web Limitations
- No background geolocation on web
- Limited camera functionality
- Different storage mechanisms
- Conditional imports required

### iOS Requirements
- Info.plist permissions for camera, location, notifications
- Background modes configuration
- Push notification certificates

### Android Requirements
- Manifest permissions
- Firebase configuration
- Background service setup
- ProGuard rules for release builds

## Local Dependencies
The project uses local path dependencies for customized packages:
- `bdaya_shared_value`: ../flutter-shared-value
- `flutter_3d_controller`: ../flutter_3d_controller
- `statusalert`: ../flutter-status-alert

Ensure these repositories are cloned at the correct relative paths.

## Integration with Panta Ecosystem
This library is designed to be imported by Panta applications:
```yaml
dependencies:
  notifi:
    path: ../notifi  # Or git URL for production
```

Applications importing this library gain access to all core features and can extend them as needed.
