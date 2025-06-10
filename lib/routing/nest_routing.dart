// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:logger/logger.dart' as logger;
// import 'package:notifi/app_state.dart' as app_state;
// import 'package:notifi/credentials.dart';
// import 'package:notifi/entities/user_role.dart';
// import 'package:notifi/i18n/strings.g.dart' as nt;
// import 'package:notifi/jwt_utils.dart';
// import 'package:notifi/models/organization.dart';
// import 'package:notifi/models/person.dart';
// import 'package:notifi/npersons/presentation/movies/npersons_search_screen.dart';
// import 'package:notifi/onboarding/onboarding_screen.dart';

// import 'package:notifi/organizations/src/features/organizations/presentation/organization_details/organization_details_screen.dart';
// import 'package:notifi/organizations/src/features/organizations/presentation/organizations/organizations_search_screen.dart';
// import 'package:notifi/pages/camera_page.dart';
// import 'package:notifi/pages/html_text_editor.dart';

// import 'package:notifi/pages/splash_page.dart';
// import 'package:notifi/pages/user_dump.dart';
// import 'package:notifi/persons/src/features/persons/domain/nperson.dart';
// import 'package:notifi/persons/src/features/persons/presentation/person_details/person_details_screen.dart';
// import 'package:notifi/registrations/src/features/registrations/domain/registration.dart';
// import 'package:notifi/registrations/src/features/registrations/presentation/registration_details/registration_details_screen.dart';
// import 'package:notifi/registrations/src/features/registrations/presentation/registrations/registrations_search_screen.dart';
// import 'package:notifi/state/nest_auth2.dart';


// var log = logger.Logger(
//   printer: logger.PrettyPrinter(),
//   level: logger.Level.info,
// );

// var logNoStack = logger.Logger(
//   printer: logger.PrettyPrinter(methodCount: 0),
//   level: logger.Level.info,
// );

// enum NestAppRoute {
//   splash,
//   onboarding,
//   onboarding1,
//   onboarding2,
//   onboarding3,
//   login,
//   camera,
//   profile,
//   home,
//   organizations,
//   organization,
//   persons,
//   person,
//   registrations,
//   registration,
//   account,
//   job,
//   addJob,
//   editJob,
//   entry,
//   addEntry,
//   editEntry,
//   dev,
//   movies,
//   movie,
//   npersons,
//   nperson
// }

// enum NestDevRoute {
//   addresslookup,
//   notify,
//   userdump,
//   html_text_editor4,
// }
// class NestRouting {

//    NestRouting({required this.homeWidget});

//    final Widget homeWidget;
//    Widget get homeWidget2 => homeWidget;

// GoRoute  nestRouteHome = GoRoute(
//         path: '/${NestAppRoute.home.name}',
//         name: NestAppRoute.home.name,
//         builder: (context, state) {
//           return new homeWidget2();
//         },
//       );


// }


// final _key = GlobalKey<NavigatorState>();

// // private navigators
// final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
// final _onboardingNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'onboarding');
// final _onboarding1NavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'onboarding1');
// final _onboarding2NavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'onboarding2');
// final _onboarding3NavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'onboarding3');
// final _organizationNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'organization');
// final _organizationsNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'organizations');
// final _personNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'person');
// final _personsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'persons');
// final _registrationNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'registration');
// final _registrationsNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'registrations');
// final _loginNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'login');
// final _cameraNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'camera');
// final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');
// final _devNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'dev');
// final _npersonsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'npersons');
// final _moviesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'movies');



// // Routes


// final nestRouterProvider = Provider<GoRouter>((ref) {
//   final isAuth = ref.watch(nestAuthProvider);

//   List<StatefulShellBranch> branchs = [];
//   branchs = [];

//   branchs.add(StatefulShellBranch(
//     navigatorKey: _homeNavigatorKey,
//     routes: [
//       GoRoute(
//         path: '/${NestAppRoute.home.name}',
//         name: NestAppRoute.home.name,
//         builder: (context, state) {
//           return HomePage();
//         },
//       ),
//     ],
//   ));


//   if (ref.read(nestAuthProvider.notifier).token != null) {
//     UserRole role = getRole(ref.read(nestAuthProvider.notifier).token!);

//     logNoStack.i("SCAFFOLD: role is $role");
//     if (role == const UserRole.dev()) {
//       branchs.add(StatefulShellBranch(
//         navigatorKey: _devNavigatorKey,
//         routes: [
//           GoRoute(
//             path: '/dev',
//             name: NestAppRoute.dev.name,
//             pageBuilder: (context, state) => const NoTransitionPage(
//               child: DevPage(),
//             ),
//           ),
//         ],
//       ));
     
//     }
//   }

//   if (enableCamera) {
//     branchs.add(StatefulShellBranch(
//       navigatorKey: _cameraNavigatorKey,
//       routes: [
//         GoRoute(
//           path: '/camera',
//           name: NestAppRoute.camera.name,
//           pageBuilder: (context, state) => const NoTransitionPage(
//             child: CameraHome(),
//           ),
//         ),
//       ],
//     ));
//   }

//   branchs.add(StatefulShellBranch(
//     navigatorKey: _organizationsNavigatorKey,
//     routes: [
//       GoRoute(
//         path: '/${NestAppRoute.organizations.name}',
//         name: NestAppRoute.organizations.name,
//         builder: (context, state) {
//           return const OrganizationsSearchScreen();
//         },
//       ),
//     ],
//   ));

//   branchs.add(StatefulShellBranch(
//     navigatorKey: _personsNavigatorKey,
//     routes: [
//       GoRoute(
//         path: '/${NestAppRoute.persons.name}',
//         name: NestAppRoute.persons.name,
//         builder: (context, state) {
//           return const NPersonsSearchScreen();
//         },
//       ),
//     ],
//   ));



//   branchs.add(StatefulShellBranch(
//     navigatorKey: _accountNavigatorKey,
//     routes: [
//       GoRoute(
//         path: '/${NestAppRoute.account.name}',
//         name: NestAppRoute.account.name,
//         builder: (context, state) {
//           return const AccountPage(); //MembersPage();
//         },
//       ),
//     ],
//   ));

//   return GoRouter(
//     navigatorKey: _key,

//     /// Forwards diagnostic messages to the dart:developer log() API.
//     debugLogDiagnostics: true,

//     /// Initial Routing Location
//     initialLocation: '/home',

//     /// The listeners are typically used to notify clients that the object has been
//     /// updated.
//     refreshListenable: ref.watch(nestAuthProvider.notifier),

//     routes: [
//       GoRoute(
//         path: '/${NestAppRoute.splash.name}',
//         name: NestAppRoute.splash.name,
//         builder: (context, state) {
//           return SplashPage(nt.t.splash_text);
//         },
//       ),

//       GoRoute(
//         path: '/${NestAppRoute.login.name}',
//         name: NestAppRoute.login.name,
//         builder: (context, state) {
//           return OnboardingScreen(pages: onboardingpages);
//         },
//       ),
//       GoRoute(
//         path: '/${NestAppRoute.onboarding.name}',
//         name: NestAppRoute.onboarding.name,
//         builder: (context, state) {
//           return OnboardingScreen(pages: onboardingpages);
//         },
//       ),
//       GoRoute(
//         path: '/${NestAppRoute.organization.name}/:id',
//         name: NestAppRoute.organization.name,
//         builder: (context, state) {
//           int id = int.parse(state.pathParameters['id']!);
//           Organization organization = state.extra as Organization;
//           return OrganizationDetailsScreen(
//               organizationId: id, organization: organization);
//         },
//       ),
//       GoRoute(
//         path: '/${NestAppRoute.person.name}/:id',
//         name: NestAppRoute.person.name,
//         builder: (context, state) {
//           int id = int.parse(state.pathParameters['id']!);
//           NPerson person = state.extra as NPerson;
//           return PersonDetailsScreen(personId: id, person: person);
//         },
//       ),
//       GoRoute(
//         path: '/${NestAppRoute.registrations.name}',
//         name: NestAppRoute.registrations.name,
//         builder: (context, state) {
//           return const RegistrationsSearchScreen();
//         },
//       ),
//       GoRoute(
//         path: '/${NestAppRoute.registration.name}/:id',
//         name: NestAppRoute.registration.name,
//         builder: (context, state) {
//           int id = int.parse(state.pathParameters['id']!);
//           Registration registration = state.extra as Registration;
//           return RegistrationDetailsScreen(
//               registrationId: id, registration: registration);
//         },
//       ),
// // DEVS
//       GoRoute(
//         path: '/${NestDevRoute.addresslookup.name}',
//         name: NestDevRoute.addresslookup.name,
//         builder: (context, state) {
//           return const AddressLookup();
//         },
//       ),

//       GoRoute(
//         path: '/${NestDevRoute.notify.name}',
//         name: NestDevRoute.notify.name,
//         builder: (context, state) {
//           return const NotifyPage();
//         },
//       ),

//       GoRoute(
//         path: '/${NestDevRoute.userdump.name}',
//         name: NestDevRoute.userdump.name,
//         builder: (context, state) {
//           return const UserDump();
//         },
//       ),

//       GoRoute(
//         path: '/${NestDevRoute.html_text_editor4.name}',
//         name: NestDevRoute.html_text_editor4.name,
//         builder: (context, state) {
//           return const HtmlTextEditor();
//         },
//       ),

//       StatefulShellRoute.indexedStack(
//         pageBuilder: (context, state, navigationShell) => NoTransitionPage(
//           child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
//         ),
//         branches: [
//           ...branchs.map(
//             (StatefulShellBranch branch) {
//               return branch;
//             },
//           ),
//         ],
//       ),
//     ],
//     redirect: (context, state) async {
//       logNoStack.d("NEST_ROUTER: incoming path request is ${state.uri.path}}");

// //  if (skipLogin ) {
// //        logNoStack.d("AUTH CONTROLLER BUILD: SKIP LOGIN DETECTED !");
// //       ref.read(nestAuthProvider.notifier).loginUsernamePassword(testUsername, testPassword);
// //       //preventAutoLogin = true; // stop it from happening.
// //     }

//       app_state.currentManager.userChanges().listen((event) async {
//         if (event?.userInfo != null) {
//           var exp = event?.claims['exp'];
//           var name = event?.claims['name'];
//           var username = event?.claims['preferred_username'];

//           var email = event?.claims['email'];
//           if (email != 'user@email.com') {
//             logNoStack
//                 .d("NEST_ROUTER: detected change user=> $email logged in");
//             // logged in!!!!
//             // force authNest
//             // ref.read(nestAuthProvider.notifier).loggedIn();
//           } else {
//             logNoStack.d("NEST_ROUTER: detected user but NO LOGIN ");
//           }
//         }
//       });
//       Person user = ref.read(nestAuthProvider.notifier).currentUser;
//       bool isLoggedIn = ref.read(nestAuthProvider.notifier).isLoggedIn;
//       logNoStack.d(
//           "NEST_ROUTER: START redirect: path=>${state.uri.path}, user is ${user.email} and is ${isLoggedIn ? 'LOGGED IN' : 'NOT LOGGED IN'}");

     
//       final path = state.uri.path;

     

//       if (isAuth) {
//         //   Person currentUser = ref.read(nestAuthProvider.notifier).currentUser;
//         Person user = ref.read(nestAuthProvider.notifier).currentUser;
//         logNoStack
//             .d("NEST_ROUTER: redirect: path=>$path , user is ${user.email}");
//         // final isLoggedIn = isAuth.value.hasValue;

//         logNoStack.d("NEST_ROUTER: redirect: path=>$path , user is LOGGED IN");
//         if (path.startsWith('/onboarding') ||
//             path.startsWith('/login') && isLoggedIn) {
//           logNoStack.d(
//               "NEST_ROUTER: redirect: path=>$path , user is LOGGED IN => returning /home");

//           return '/home';
//         }
//       } else {
//         logNoStack
//             .d("NEST_ROUTER: redirect: path=>$path , user is NOT LOGGED IN");
//         if (
//             //path.startsWith('/onboarding') || // covers all onboarding pages
//             path.startsWith('/home') ||
//                 path.startsWith('/camera') ||
//                 path.startsWith('/dev') ||
//                 path.startsWith('/account') ||
//                 path.startsWith('/organizations') ||
//                 path.startsWith('/organization') ||
//                 path.startsWith('/npersons') ||
//                 path.startsWith('/nperson') ||
//                 path.startsWith('/persons') ||
//                 path.startsWith('/person')) {
//           return '/login';
//         }
//       }
//       return null;
//     },
//   );
// });


