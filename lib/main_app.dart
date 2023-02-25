import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/screens/app/single_dream_screen.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dependency_injection.dart';
import 'package:dream_catcher/services/model_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
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

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      //    call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
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
        child: MaterialApp(
            builder: Authenticator.builder(),
            home: Portal(
              child: GestureDetector(
                  onTap: () {
                    // FocusScope.of(context).requestFocus(FocusNode());
                    // SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  child: const SingleDreamScreen()),
            )),
      ),
    );
  }
}
