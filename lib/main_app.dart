import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/routing/router.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/services/model_service.dart';
import 'package:dream_catcher/services/user_service.dart';
import 'package:dream_catcher/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelService>(create: (context) => getIt<ModelService>()),
        ChangeNotifierProvider<DreamService>(create: (context) => getIt<DreamService>()),
        ChangeNotifierProvider<UserService>(create: (context) => getIt<UserService>()),
      ],
      child: Portal(
        child: GestureDetector(
            onTap: () {
              // FocusScope.of(context).requestFocus(FocusNode());
              // SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: GetMaterialApp.router(
              //   builder: Authenticator.builder(),
              title: "Dream Catcher", // This title appears on a web browser tab.
              enableLog: false,
              debugShowCheckedModeBanner: false,
              // theme: theme(context),
              theme: lightTheme,
              routeInformationParser: routeParser,
              routerDelegate: router,
            )),
      ),
    );
  }
}
