import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soq_app/presentation/bloc/layout_bloc/layout_cubit.dart';
import 'package:soq_app/presentation/bloc/onboarding/onboarding_cubit.dart';
import 'package:soq_app/presentation/pages/cart/cart_view.dart';
import 'package:soq_app/presentation/pages/favorites/favorites_view.dart';
import 'package:soq_app/presentation/pages/home/home_view.dart';
import 'package:soq_app/presentation/pages/layout/layout_view.dart';
import 'package:soq_app/presentation/pages/login/login_view.dart';
import 'package:soq_app/presentation/pages/onboarding/onboarding_view.dart';
import 'package:soq_app/presentation/pages/register/register_view.dart';
import 'package:soq_app/presentation/pages/settings/settings_view.dart';
import 'package:soq_app/presentation/pages/splash/splash_view.dart';
import 'package:soq_app/presentation/recources/strings_manger.dart';
import 'package:soq_app/presentation/screens/search_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "onBoardingRoute";
  static const String loginRoute = "loginRoute";
  static const String layoutRoute = "layoutRoute";
  static const String homeRoute = "homeRoute";
  static const String favoritesRoute = "favoritesRoute";
  static const String cartRoute = "cartRoute";
  static const String settingsRoute = "settingsRoute";
  static const String register = "register";
  static const String searchRoute = "searchRoute";
  static const String descriptionRoute = "descriptionRoute";
}

class RouteGenerator {
  Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OnBoardingCubit(),
            child: const OnBoardingView(),
          ),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case Routes.layoutRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => LayoutCubit(),
                  child: const Layout(),
                ));
      case Routes.register:
        return MaterialPageRoute(
          builder: (context) => RegisterView(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
      case Routes.favoritesRoute:
        return MaterialPageRoute(
          builder: (context) => Builder(builder: (context) {
            return const FavoritesView();
          }),
        );
      case Routes.cartRoute:
        return MaterialPageRoute(
          builder: (context) => const CartView(),
        );
      case Routes.settingsRoute:
        return MaterialPageRoute(
          builder: (context) => SettingsView(),
        );
      case Routes.searchRoute:
        return MaterialPageRoute(
          builder: (context) => SearchScreen(),
        );

      default:
        return unDefainedRote();
    }
  }

  static Route<dynamic> unDefainedRote() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRoureFound),
        ),
        body: Center(
          child: Text(
            AppStrings.noRoureFound,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      );
    });
  }
}
