import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medi_care_hub/core/router/routes.dart';
import 'package:medi_care_hub/core/services/service_locator.dart';
import 'package:medi_care_hub/features/auth/domain/repos/signin_repo.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:medi_care_hub/features/auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:medi_care_hub/features/auth/presentation/views/signin_view.dart';
import 'package:medi_care_hub/features/auth/presentation/views/signup_view.dart';
import 'package:medi_care_hub/features/home/presentation/views/home_view.dart';
import 'package:medi_care_hub/features/onboarding/presentation/views/onboarding_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '_root');

final router = GoRouter(
  initialLocation: Routes.onboarding,
  navigatorKey: _rootNavigatorKey,
  errorBuilder: (context, state) {
    // CustomButtonP
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops! Page not found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => context.go(Routes.home), // Redirect to home
            //   child: const Text('Go to Home'),
            // ),
          ],
        ),
      ),
    );
  },
  routes: [
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: Routes.signin,
      builder: (context, state) => BlocProvider(
        create: (context) => SigninCubit(sl<SigninRepo>()),
        child: const SigninView(),
      ),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => BlocProvider(
        create: (context) => AuthCubit()..loadUser(),
        child: const HomeView(),
      ),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) => const SignupView(),
    )

    // StatefulShellRoute.indexedStack(
    //   branches: [
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: Routes.home,
    //           builder: (context, state) => const HomeView(),
    //           routes: [
    //             //this makes the nav bar showing
    //             GoRoute(
    //               path: Routes.nestedBestSelling,
    //               builder: (context, state) => const BestSellingView(),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: Routes.cart,
    //           builder: (context, state) => const Cart(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: Routes.products,
    //           builder: (context, state) => const Products(),
    //         ),
    //       ],
    //     ),
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: Routes.profile,
    //           builder: (context, state) => const Profile(),
    //         ),
    //       ],
    //     ),
    //   ],
    //   builder: (context, state, navigationShell) => NavigationBarLayout(
    //     shell: navigationShell,
    //   ),
    // ),
  ],
);
