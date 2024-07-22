import 'dart:async';

import 'package:chat_application/src/base/constant/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/di/get_it.dart' as get_it;
import 'src/di/get_it.dart';
import 'src/pages/loading_page.dart';
import 'src/provider/loading_provider.dart';
import 'src/base/routing/route_generator.dart';
import 'src/base/routing/route_names.dart';
import 'src/base/utils/shared_preference_manager.dart';
import 'src/base/utils/size_helper/screen_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferenceManager.init();
  get_it.getInstance.registerSingleton(LoadingProvider());
  get_it.getInstance.registerSingleton(GlobalKey<NavigatorState>());
  unawaited(get_it.init());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LoadingProvider loadingProvider;
  @override
  void initState() {
    super.initState();
    loadingProvider = getInstance<LoadingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ScreenUtil.init(constraints,
          orientation: Orientation.portrait,
          designSize: ScreenUtil.defaultSize);
      return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => loadingProvider)],
        child: MaterialApp(
          title: 'Chit-Chat',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: greenColor),
            useMaterial3: true,
          ),
          builder: (context, child) {
            return LoadingPage(screen: child!);
          },
          debugShowCheckedModeBanner: false,
          initialRoute: RouteNames.initialRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      );
    });
  }
}
