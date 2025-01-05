
// import 'package:go_router/go_router.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:formulacionesctu/features/auth/auth.dart';
// import 'package:formulacionesctu/features/auth/presentation/screens/screens.dart';
// import 'package:formulacionesctu/features/auth/presentation/providers/auth_provider.dart';
// import 'app_router_notifier.dart';


// final goRouterProvider = Provider<GoRouter>((ref) {

//     final goRouterNotifier = ref.read(goRouterNotifierProvider);

//   final isLoggedIn = ref.watch(authProvider) != null;

//   return GoRouter(
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => isLoggedIn ? const HomeScreen() : LoginScreen(),
//       ),
//       GoRoute(
//         path: '/login',
//         builder: (context, state) => LoginScreen(),
//       ),
//       GoRoute(
//         path: '/register',
//         builder: (context, state) => RegisterScreen(),
//       ),
//     ],
    
   
//   );
  
// });

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formulacionesctu/features/auth/auth.dart';
import 'package:formulacionesctu/features/auth/presentation/screens/screens.dart';
import 'package:formulacionesctu/features/auth/presentation/providers/auth_provider.dart';
import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
        //builder: (context, state) => const HomeScreen(),

      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const ProductsScreen(),
      // ),
      // GoRoute(
      //   path: '/product/:id', // /product/new
      //   builder: (context, state) => ProductScreen(
      //     productId: state.params['id'] ?? 'no-id',
      //   ),
      // ),
    ],

    redirect: (context, state) {
      
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' ) return null;

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash' ){
           return '/';
        }
      }


      return null;
    },
  );
});
