import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soq_app/app/app_prefs.dart';
import 'package:soq_app/app/injection_container.dart';
import 'package:soq_app/presentation/bloc/home_bloc/home_cubit.dart';

import 'package:soq_app/presentation/recources/route_manger.dart';
import 'package:soq_app/presentation/recources/them_manger.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final RouteGenerator _routeGenerator = RouteGenerator();
  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit()
              ..getHome()
              ..getFavorites()
              ..getCart()
              ..getProfile(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: _routeGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          theme: getThemData(),
        ));
  }
}
