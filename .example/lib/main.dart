
import 'package:bdaya_shared_value/bdaya_shared_value.dart';
import 'package:flutter/foundation.dart'; // Importing Flutter foundation package
import 'package:flutter/material.dart'; // Importing Flutter material design package
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:flutter_localizations/flutter_localizations.dart'; // Importing localization support
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logger/logger.dart' as logger;
import 'package:notifi/app_state.dart' as app_state;
import 'package:notifi/credentials.dart';
import 'package:notifi/jwt_utils.dart';
import 'package:notifi/notifi.dart'; // Importing notification package
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:provider/provider.dart'; // Importing provider for state management
import 'package:shared_preferences/shared_preferences.dart'; // Importing shared preferences for persistent storage
import 'package:background_fetch/background_fetch.dart';
import 'firebase_options.dart';
import 'i18n/strings.g.dart'; // Importing localization strings
import 'routes.dart'; // Importing application routes

var log = logger.Logger(
  printer: logger.PrettyPrinter(),
  level: logger.Level.info,
);

var logNoStack = logger.Logger(
  printer: logger.PrettyPrinter(methodCount: 0),
  level: logger.Level.info,
);



// Be sure to annotate your callback for Flutter >= 3.3.0
@pragma('vm:entry-point')
void headlessTask(bg.HeadlessEvent headlessEvent) async {
  if (!kIsWeb)  {
    return;
  }
  logNoStack.i('[BackgroundGeolocation HeadlessTask]: $headlessEvent');
  // Implement a 'case' for only those events you're interested in.
  switch(headlessEvent.name) {
    case bg.Event.TERMINATE:
      bg.State state = headlessEvent.event;
      logNoStack.i('- State: $state');
      break;
    case bg.Event.HEARTBEAT:
      bg.HeartbeatEvent event = headlessEvent.event;
      logNoStack.i('- HeartbeatEvent: $event');
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      logNoStack.i('- Location: $location');
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      logNoStack.i('- Location: $location');
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = headlessEvent.event;
      logNoStack.i('- GeofenceEvent: $geofenceEvent');
      break;
    case bg.Event.GEOFENCESCHANGE:
      bg.GeofencesChangeEvent event = headlessEvent.event;
      logNoStack.i('- GeofencesChangeEvent: $event');
      break;
    case bg.Event.SCHEDULE:
      bg.State state = headlessEvent.event;
      logNoStack.i('- State: $state');
      break;
    case bg.Event.ACTIVITYCHANGE:
      bg.ActivityChangeEvent event = headlessEvent.event;
      logNoStack.i('ActivityChangeEvent: $event');
      break;
    case bg.Event.HTTP:
      bg.HttpEvent response = headlessEvent.event;
      logNoStack.i('HttpEvent: $response');
      if (response.success == false) {
       var oidcUser = await app_state.currentManager.refreshToken();
       ref.read(currentUserProvider.notifier).setOidc(oidcUser);
      }
      break;
    case bg.Event.POWERSAVECHANGE:
      bool enabled = headlessEvent.event;
      logNoStack.i('ProviderChangeEvent: $enabled');
      break;
    case bg.Event.CONNECTIVITYCHANGE:
      bg.ConnectivityChangeEvent event = headlessEvent.event;
      logNoStack.i('ConnectivityChangeEvent: $event');
      break;
    case bg.Event.ENABLEDCHANGE:
      bool enabled = headlessEvent.event;
      logNoStack.i('EnabledChangeEvent: $enabled');
      break;
  }
}

/// Receive events from BackgroundFetch in Headless state.
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;

  // Is this a background_fetch timeout event?  If so, simply #finish and bail-out.
  if (task.timeout) {
    logNoStack.d("[BackgroundFetch] HeadlessTask TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  logNoStack.d("[BackgroundFetch] HeadlessTask: $taskId");

  try {
    var location = await bg.BackgroundGeolocation.getCurrentPosition(
        samples: 2, extras: {"event": "background-fetch", "headless": true});
    logNoStack.d("[location] $location");
  } catch (error) {
    logNoStack.d("[location] ERROR: $error");
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int count = 0;
  if (prefs.get("fetch-count") != null) {
    count = prefs.getInt("fetch-count")!;
  }
  prefs.setInt("fetch-count", ++count);
  logNoStack.d('[BackgroundFetch] count: $count');

  BackgroundFetch.finish(taskId);
}

void main() async {
  usePathUrlStrategy();

  
  // Main entry point of the application
  final runnableApp = _buildRunnableApp(
    // Build the runnable app
    isWeb: kIsWeb,
    webAppWidth: 2048.0,
    app: const MainApp(),
  );

  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter binding is initialized
  WidgetsApp.debugAllowBannerOverride = false; // Disable debug banner
  LocaleSettings.useDeviceLocale(); // Set locale to device's locale

  final config =
      PostHogConfig(posthogKey);
  config.host = 'https://us.i.posthog.com';
  config.debug = true;
  config.captureApplicationLifecycleEvents = true;

  // check https://posthog.com/docs/session-replay/installation?tab=Flutter
  // for more config and to learn about how we capture sessions on mobile
  // and what to expect
  config.sessionReplay = true;
  // choose whether to mask images or text
  config.sessionReplayConfig.maskAllTexts = false;
  config.sessionReplayConfig.maskAllImages = false;

  // Setup PostHog with the given Context and Config
  await Posthog().setup(config);

  logNoStack.d("Main:Entering State 0 , Running main.dart");
  logNoStack.d("Main:default Realm = $defaultRealm");
  logNoStack.d("Main:default Auth Base URL = $defaultAuthBaseUrl");
  logNoStack.d("Main:default Discovery URL = $defaultDiscoveryUrl");
  logNoStack.d("Main:default ClientId = $defaultClientId");
  logNoStack.d("Main:default Client Secret = $defaultClientSecret");
  logNoStack.d("Main:default Redirect URL = $defaultRedirectUrl");
  logNoStack.d("Main:default API Base URL = $defaultAPIBaseUrl");
  logNoStack.d("Main:default Mobile Path = $defaultMobilePath");
  logNoStack.d(
      "Main:default Auth Endpoint URL = $defaultAuthEndpointUrl");
  logNoStack.d("");

  
  LocaleSettings.getLocaleStream().listen((event) {
    // Listen for locale changes
    logNoStack.d('locale changed: $event');
  });

  var packageInfo = await fetchPackageInfo();
  String deviceId = await fetchDeviceId();

  logNoStack.i("deviceId is $deviceId!");

  SharedPreferences.getInstance().then((SharedPreferences prefs) {
    runApp(
      // Run the application
      /// Providers are above [MyApp] for testing purposes
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Notifi(
      // Initialize notification system
      options: DefaultFirebaseOptions.currentPlatform,
      vapidKey: vapidKey,
      secondsToast: 4,
      topics: [defaultRealm],
      packageInfo: packageInfo,
      deviceId: deviceId,
      ))
        ],
        child: TranslationProvider(child: runnableApp),
      ),
    );
  });



  
  if (!kIsWeb) {
    bg.BackgroundGeolocation.registerHeadlessTask(headlessTask);
          /// Register BackgroundFetch headless-task.
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  }
}



class MainApp extends StatelessWidget {
  // Main application widget
  const MainApp({super.key}); // Constructor

  @override // Override build method
  Widget build(BuildContext context) {
      
    // Build method for the widget

    return PostHogWidget(
        child: SharedValue.wrapApp(
      MaterialApp.router(
        theme: ThemeData.light(useMaterial3: true),
        routerConfig: router,
        locale: TranslationProvider.of(context).flutterLocale,
        // AppLocaleUtils is a class generated by the slang package
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
         builder: (context, child) {
          /// A platform-agnostic way to initialize
          /// the app state before displaying the routes.
          return FutureBuilder(
            future: app_state.initApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return child!;
            },
          );
        },
      ),
    ));
  }
}

Widget _buildRunnableApp({
  // Function to build the runnable app
  required bool isWeb,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    // Check if the platform is not web
    return app;
  }

  return Center(
    // Center the app for web
    child: ClipRect(
      // Clip the app to a rectangle
      child: SizedBox(
        // Set the size of the app
        width: webAppWidth,
        child: app,
      ),
    ),
  );
}
