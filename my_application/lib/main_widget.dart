import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_application/core/providers/user.role.provider.dart';
import 'package:my_application/core/route/go_router_provider.dart';

// class MainWidget extends ConsumerWidget {
//   const MainWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final goRouterAsync = ref.watch(userRoleProvider);
//     return goRouterAsync.when(
//       data: (_) {
//         final router = ref.watch(goRouterProvider);
//         return MaterialApp.router(
//           routerConfig: router,
//           title: 'My Application',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             visualDensity: VisualDensity.adaptivePlatformDensity,
//             scaffoldBackgroundColor: Colors.white,
//             appBarTheme: const AppBarTheme(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               iconTheme: IconThemeData(color: Colors.black),
//             ),
//             bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//               backgroundColor: Colors.white,
//               selectedItemColor: Colors.black,
//               unselectedItemColor: Colors.black,
//             ),
//             iconTheme: const IconThemeData(color: Colors.black),
//           ),
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error:
//           (error, stack) => MaterialApp(
//             home: Scaffold(body: Center(child: Text('Error: $error'))),
//           ),
//     );
//   }
// }

class MainWidget extends ConsumerWidget {
  const MainWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);

    // ref.listen<AsyncValue<String?>>(userRoleProvider, (previous, next) {
    //   debugPrint("MyApp: userRoleProvider state changed! Previous: ${previous?.value}, Next: ${next.value}, Is Loading: ${next.isLoading}");
    // });


    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'RBAC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
    );
  }
}