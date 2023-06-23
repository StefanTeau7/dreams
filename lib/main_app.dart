import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/routing/router.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dream_service.dart';
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
          case AuthenticatorStep.confirmSignUp:
            return Scaffold(
              backgroundColor: Styles.deepOceanBlue,
              body: Container(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icon/icon.png"),
                            ),
                            color: Styles.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Plume",
                        style: Styles.uiBoldExtraLarge,
                      ),
                      // prebuilt confirm sign up form from amplify_authenticator package
                      ConfirmSignUpForm(),
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
          case AuthenticatorStep.verifyUser:
            return Scaffold(
              backgroundColor: Styles.deepOceanBlue,
              body: Container(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icon/icon.png"),
                            ),
                            color: Styles.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Plume",
                        style: Styles.uiBoldExtraLarge,
                      ),
                      // prebuilt verify user form from amplify_authenticator package
                      VerifyUserForm(),
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
          case AuthenticatorStep.resetPassword:
            return Scaffold(
              backgroundColor: Styles.deepOceanBlue,
              body: Container(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icon/icon.png"),
                            ),
                            color: Styles.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Plume",
                        style: Styles.uiBoldExtraLarge,
                      ),
                      // prebuilt reset password form from amplify_authenticator package
                      ResetPasswordForm(),
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
          case AuthenticatorStep.signIn:
            return Scaffold(
              backgroundColor: Styles.deepOceanBlue,
              body: Container(
                color: Styles.deepOceanBlue,
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icon/icon.png"),
                            ),
                            color: Styles.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Plume",
                        style: Styles.uiBoldExtraLarge,
                      ),
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
              backgroundColor: Styles.deepOceanBlue,
              body: Container(
                padding: padding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icon/icon.png"),
                            ),
                            color: Styles.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Plume",
                        style: Styles.uiBoldExtraLarge,
                      ),
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
