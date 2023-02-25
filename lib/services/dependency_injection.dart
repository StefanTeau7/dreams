import 'package:dream_catcher/services/chat_service.dart';
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
}
