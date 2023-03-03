import 'package:dream_catcher/models/models.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ModelService with ChangeNotifier {
  String currentModel = "gpt-3.5-turbo";
  List<Model> _modelsList = [];

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<Model> modelsList = [];

  List<Model> get getModelsList {
    return _modelsList;
  }

  Future<List<Model>> getAllModels() async {
    _modelsList = await ApiService.getModels();
    return _modelsList;
  }
}
