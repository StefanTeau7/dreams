import 'package:dream_catcher/models/models.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class ModelService with ChangeNotifier {
  List<Model> _modelsList = [];

  List<Model> get getModelsList {
    return _modelsList;
  }

  Future<List<Model>> getAllModels() async {
    _modelsList = await ApiService.getModels();
    return _modelsList;
  }
}
