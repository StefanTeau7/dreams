import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/routing/router.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/services/model_service.dart';
import 'package:dream_catcher/services/user_service.dart';
import 'package:dream_catcher/styles/styles.dart';
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
    return Authenticator(
      authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
        const padding = EdgeInsets.all(20);
        switch (state.currentStep) {
          case AuthenticatorStep.signIn:
            return Scaffold(
              backgroundColor: Styles.wine,
              body: Container(
                color: Styles.wine,
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // app logo
                      const Center(child: FlutterLogo(size: 100)),
                      // prebuilt sign in form from amplify_authenticator package
                      SignInForm(),
                    ],
                  ),
                ),
              ),
              // custom button to take the user to sign up
              persistentFooterButtons: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () => state.changeStep(
                        AuthenticatorStep.signUp,
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            );
          case AuthenticatorStep.signUp:
            return Scaffold(
              backgroundColor: Styles.wine,
              body: Container(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // app logo
                      const Center(child: FlutterLogo(size: 100)),
                      // prebuilt sign up form from amplify_authenticator package
                      SignUpForm(),
                    ],
                  ),
                ),
              ),
              // custom button to take the user to sign in
              persistentFooterButtons: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => state.changeStep(
                        AuthenticatorStep.signIn,
                      ),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            );
          default:
            // returning null defaults to the prebuilt authenticator for all other steps
            return null;
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserService>(create: (context) => getIt<UserService>()),
          ChangeNotifierProvider<ModelService>(create: (context) => getIt<ModelService>()),
          ChangeNotifierProvider<DreamService>(create: (context) => getIt<DreamService>()),
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
