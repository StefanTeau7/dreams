import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/amplifyconfiguration.dart';
import 'package:dream_catcher/models/ModelProvider.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/services/model_service.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> registerServices() async {
  getIt.registerSingleton<ModelService>(ModelService());
  getIt.registerSingleton<ChatService>(ChatService());
}

Future<void> initializeServices() async {
  ModelService modelService = getIt<ModelService>();
  await modelService.getAllModels();
  await _configureAmplify();
  DreamService.queryListItems();
}

_configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    AmplifyDataStore datastorePlugin = AmplifyDataStore(
      modelProvider: ModelProvider.instance,
      errorHandler: ((error) => {print("Custom ErrorHandler received: " + error.toString())}),
    );
    await Amplify.addPlugin(datastorePlugin);
    await Amplify.configure(amplifyconfig);
    print('Successfully configured');
    return;
  } on Exception catch (e) {
    print('Error configuring Amplify: $e');
    return;
  }
}
