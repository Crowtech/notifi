# Migration Guide: Notifi Library Refactoring

This guide helps you migrate from the old `notifi.dart` and `notifi2.dart` implementations to the new refactored architecture.

## Overview of Changes

### Architecture Improvements
- **Consolidated Implementation**: Combined `notifi.dart` and `notifi2.dart` into a single, cohesive architecture
- **Separation of Concerns**: Split functionality into focused services (notifications, camera, platform utilities)
- **Consistent State Management**: Standardized on Riverpod throughout the library
- **Better Error Handling**: Improved error handling and logging
- **Platform Abstraction**: Extracted platform-specific code into `PlatformHelper`

### New File Structure
```
lib/
├── core/
│   ├── notifications/
│   │   ├── notification_service.dart    # Main notification service
│   │   ├── notification_handler.dart    # Message handling logic
│   │   ├── topic_manager.dart          # FCM topic management
│   │   └── platform_helper.dart        # Platform detection utilities
│   └── camera/
│       └── camera_service.dart          # Camera functionality
├── utils/
│   └── logger.dart                      # Centralized logging
└── notifi_refactored.dart              # New main entry point
```

## Migration Steps

### 1. Update Imports

**Old:**
```dart
import 'package:notifi/notifi.dart';
// or
import 'package:notifi/notifi2.dart';
```

**New:**
```dart
import 'package:notifi/notifi_refactored.dart';
```

### 2. Initialize the Library

**Old (notifi.dart):**
```dart
final notifi = Notifi();
await notifi.init(
  context: context,
  cameras: cameras,
  package: packageInfo,
  user: currentUser,
);
```

**Old (notifi2.dart):**
```dart
// In a Riverpod provider
final notifi2 = ref.watch(Notifi2());
```

**New:**
```dart
// In main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final container = ProviderContainer();
  await initializeNotifi(container);
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}
```

### 3. Access Services

**Old:**
```dart
// Access through Notifi instance
notifi.fcmToken;
notifi.addTopic('news');
notifi.cameras;
```

**New:**
```dart
// Access through Riverpod providers
final notificationService = ref.watch(notificationServiceProvider);
final cameraService = ref.watch(cameraServiceProvider);
final fcmToken = ref.watch(fcmNotifierProvider).value?.fcmToken;
```

### 4. Topic Management

**Old:**
```dart
notifi.addTopic('news');
notifi.removeTopic('news');
notifi.subscribeToTopics();
```

**New:**
```dart
// Using the service directly
final service = await ref.read(notificationServiceProvider.future);
await service.subscribeToTopics(['news', 'updates']);
await service.unsubscribeFromTopics(['news']);

// Or using helper functions
await subscribeToTopics(container, ['news', 'updates']);
```

### 5. Show Notifications

**Old:**
```dart
// Not directly available in old implementation
```

**New:**
```dart
await showNotification(
  container,
  title: 'Hello',
  body: 'This is a notification',
  payload: jsonEncode({'id': '123'}),
);
```

### 6. Camera Access

**Old:**
```dart
final cameras = notifi.cameras;
```

**New:**
```dart
final cameraService = ref.watch(cameraServiceProvider);
final cameras = cameraService.value?.cameras ?? [];

// Initialize camera controller
final controller = await ref.read(cameraServiceProvider.notifier)
    .initializeController(cameras.first);

// Take a picture
final image = await ref.read(cameraServiceProvider.notifier).takePicture();
```

### 7. Platform Detection

**Old:**
```dart
if (!kIsWeb && Platform.isIOS) {
  // iOS specific code
}
```

**New:**
```dart
if (PlatformHelper.isIOS) {
  // iOS specific code
}

// More helpers available:
PlatformHelper.isMobile;      // iOS or Android
PlatformHelper.isDesktop;     // macOS, Windows, or Linux
PlatformHelper.platformName;  // Returns platform as string
```

### 8. Logging

**Old:**
```dart
log('Message');
logNoStack('Message');
```

**New:**
```dart
logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message', error: e, stackTrace: stack);

// Without stack trace
logNoStack('Message');
```

## Provider Changes

### FCM Token
**Old:**
```dart
final token = notifi.fcmToken;
```

**New:**
```dart
final fcmState = ref.watch(fcmNotifierProvider);
final token = fcmState.value?.fcmToken;
```

### User Authentication
**Old:**
```dart
final user = notifi.user;
```

**New:**
```dart
final auth = ref.watch(nestAuthProvider);
final user = auth?.user;
```

## Removed Features

The following features have been removed or need to be implemented differently:

1. **Direct ChangeNotifier Access**: The new implementation uses Riverpod providers exclusively
2. **preventAutoLogin**: This should be handled in your authentication logic
3. **Package Info Management**: Should be handled separately using `package_info_plus`

## Benefits of Migration

1. **Better Performance**: More efficient state management with Riverpod
2. **Improved Testability**: Services can be easily mocked and tested
3. **Cleaner Code**: Better separation of concerns
4. **Type Safety**: Stronger type checking with code generation
5. **Easier Maintenance**: Modular architecture makes updates easier

## Troubleshooting

### Common Issues

1. **Provider not found errors**
   - Ensure you've wrapped your app with `ProviderScope` or `UncontrolledProviderScope`
   - Make sure to run code generation: `flutter pub run build_runner build`

2. **Initialization errors**
   - Check that Firebase is properly configured
   - Ensure all required permissions are requested

3. **Camera not working**
   - Verify camera permissions are granted
   - Check that camera service is initialized

### Debug Mode

To enable debug logging:
```dart
// The logger is already configured for debug level
logger.level = Level.debug;
```

## Example: Complete Migration

Here's a complete example showing the migration:

**Before:**
```dart
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Notifi notifi;
  
  @override
  void initState() {
    super.initState();
    notifi = Notifi();
    _initializeNotifi();
  }
  
  Future<void> _initializeNotifi() async {
    await notifi.init(
      context: context,
      cameras: await availableCameras(),
    );
    
    notifi.addTopic('general');
    notifi.subscribeToTopics();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('FCM Token: ${notifi.fcmToken}'),
        ),
      ),
    );
  }
}
```

**After:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final container = ProviderContainer();
  await initializeNotifi(container);
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fcmState = ref.watch(fcmNotifierProvider);
    
    // Subscribe to topics on first build
    ref.listen(notificationServiceProvider, (previous, next) {
      next.whenData((service) {
        service.subscribeToTopics(['general']);
      });
    });
    
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: fcmState.when(
            data: (data) => Text('FCM Token: ${data.fcmToken}'),
            loading: () => CircularProgressIndicator(),
            error: (e, s) => Text('Error: $e'),
          ),
        ),
      ),
    );
  }
}
```

## Need Help?

If you encounter any issues during migration:
1. Check the example app for reference implementations
2. Review the API documentation in the source files
3. Enable debug logging to troubleshoot issues
4. Contact the Crowtech development team for support