import 'package:dream_catcher/models/models.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ModelService with ChangeNotifier {
  String currentModel = "curie";
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<Model> modelsList = [];

  List<Model> get getModelsList {
    return modelsList;
  }

  Future<List<Model>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
