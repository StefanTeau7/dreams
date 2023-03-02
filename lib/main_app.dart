import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/models/ModelProvider.dart';
import 'package:dream_catcher/routing/router.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dependency_injection.dart';
import 'package:dream_catcher/services/model_service.dart';
import 'package:dream_catcher/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'amplifyconfiguration.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      AmplifyDataStore datastorePlugin = AmplifyDataStore(
        modelProvider: ModelProvider.instance,
        errorHandler: ((error) => {print("Custom ErrorHandler received: " + error.toString())}),
      );
      await Amplify.addPlugin(datastorePlugin);
      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ModelService>(create: (context) => getIt<ModelService>()),
          ChangeNotifierProvider<ChatService>(create: (context) => getIt<ChatService>()),
        ],
        child: Portal(
          child: GestureDetector(
              onTap: () {
                // FocusScope.of(context).requestFocus(FocusNode());
                // SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              child: GetMaterialApp.router(
                builder: Authenticator.builder(),
                title: "Dream Catcher", // This title appears on a web browser tab.
                enableLog: false,
                debugShowCheckedModeBanner: false,
                // theme: theme(context),
                theme: lightTheme,
                routeInformationParser: routeParser,
                routerDelegate: router,
              )),
        ),
      ),
    );
  }
}
