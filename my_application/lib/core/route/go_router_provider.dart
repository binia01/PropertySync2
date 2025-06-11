import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_application/core/data/remote/network_service.dart';
import 'package:my_application/core/data/remote/token/token_service.dart';
import 'package:my_application/core/route/route_name.dart';
import 'package:my_application/features/appointment/presentation/ui/appointment_screen.dart';
import 'package:my_application/features/auth/login/presentation/ui/login_screen.dart';
import 'package:my_application/features/auth/signup/presentation/ui/signup_screen.dart';
import 'package:my_application/features/property/presentation/ui/create_property.dart';
import 'package:my_application/features/property/presentation/ui/property_screen.dart';
import 'package:my_application/features/user/presentation/ui/user_screen.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  debugPrint("goRouterProvider: Router rebuild triggered.");
  final asyncUserRole = ref.watch(userRoleProvider);


  final String? role = asyncUserRole.value?.role;
  final String? userId = asyncUserRole.value?.userId;
  final bool isLoading = asyncUserRole.isLoading;
  final bool isLoggedIn = role != null && role.isNotEmpty && userId != null && userId.isNotEmpty;
  final bool isSeller = role?.toUpperCase() == 'SELLER';
  debugPrint("goRouterProvider: asyncUserRole: value=${asyncUserRole.value}, isLoading=${asyncUserRole.isLoading}, isLoggedIn=$isLoggedIn");

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: "/signup",
    routes: [
      GoRoute(
        path: '/login',
        name: loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: signupRoute,
        builder: (context, state) => const SignupScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          final currentIndex = state.getCurrentIndex(isSeller);

          void onTap(int index) {
            if (isSeller) {
              switch (index) {
                case 0:
                  context.go('/property');
                  break;
                case 1:
                  context.go('/appointment');
                  break;
                case 2:
                  context.go('/createProperty');
                  break;
                case 3:
                  context.go('/profile');
                  break;
              }
            } else {
              switch (index) {
                case 0:
                  context.go('/property');
                  break;
                case 1:
                  context.go('/appointment');
                  break;
                case 2:
                  context.go('/profile');
                  break;
              }
            }
          }

          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'Appointments',
                ),
                if (isSeller)
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.create_outlined),
                    label: 'Add Property',
                  ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/property',
            name: propertyPageRoute,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const PropertyListScreen(),
          ),
          GoRoute(
            path: '/appointment',
            name: appointmentPageRoute,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const AppointmentListScreen(),
          ),
          if (isSeller)
            GoRoute(
              path: '/createProperty',
              name: createPropertyPageRoute,
              parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => const CreatePropertyPage(),
            ),
          GoRoute(
            path: '/profile',
            name: userProfileRoute,
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const UserScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final String location = state.matchedLocation;
      final bool goingToLogin = location == '/login';
      final bool goingToSignup = location == '/signup';

      debugPrint("goRouterProvider: Redirect function invoked.");
      debugPrint("goRouterProvider: Current path: $location");
      debugPrint("goRouterProvider: Is loading: $isLoading");
      debugPrint("goRouterProvider: Is logged in: $isLoggedIn");

      if (isLoading) {
        debugPrint("goRouterProvider: Still loading, allowing login/signup/splash or staying put.");
        if (goingToLogin || goingToSignup ) {
          return null;
        }
        return null;
      }

      if (!isLoggedIn) {
        debugPrint("goRouterProvider: Not logged in.");
        if (goingToLogin || goingToSignup) {
          debugPrint("goRouterProvider: Allowing navigation to login/signup.");
          return null;
        }
        debugPrint("goRouterProvider: Redirecting to /login.");
        return '/login';
      }

      debugPrint("goRouterProvider: Logged in.");
      if (isLoggedIn && (goingToLogin || goingToSignup)) {
        debugPrint("goRouterProvider: Logged in, redirecting from login/signup to /property.");
        return '/property';
      }

      debugPrint("goRouterProvider: No redirect needed, staying on current path.");
      return null;
    },
  );
});

extension ShellStateExtension on GoRouterState {
  int getCurrentIndex(bool isSeller) {
    final location = matchedLocation;
    if (location.startsWith('/property')) return 0;
    if (location.startsWith('/appointment')) return 1;
    if (isSeller && location.startsWith('/createProperty')) return 2;
    if (location.startsWith('/profile')) return isSeller ? 3 : 2;
    return 0;
  }
}
