import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/models/dream.dart';

class DreamService {
  static final Map<String, Dream> _dreamsById = {};

  static List<Dream> getAllMyDreams() {
    return _dreamsById.values.toList();
  }

  static Future<void> createDream(String subject, String summary) async {
    try {
      final model = Dream(
        subject: subject,
        //   user: null,
        id: null,
      );

      await Amplify.DataStore.save(model);
      // final request = ModelMutations.create(model);
      // final response = await Amplify.API.mutate(request: request).response;
      // final createdDream = response.data;
      // if (createdDream == null) {
      //   safePrint('errors: ${response.errors}');
      //   return;
      // }
      // safePrint('Mutation result: ${createdDream.id}');
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
    }
  }

  Future<void> updateDream(Dream originalDream) async {
    final updatedModel = originalDream.copyWith(
      subject: "Lorem ipsum dolor sit amet",
    );

    // final request = ModelMutations.update(updatedModel);
    // final response = await Amplify.API.mutate(request: request).response;
    // print('Response: $response');
  }

  static Future<List<Dream?>> queryListItems() async {
    try {
      final items = await Amplify.DataStore.query(Dream.classType);
      // final request = ModelQueries.list(Dream.classType);
      // final response = await Amplify.API.query(request: request).response;
      // final items = response.data?.items;

      for (Dream dream in items) {
        _dreamsById[dream.id] = dream;
      }
      print('Dreams: $items');
      return items;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return <Dream?>[];
  }
}
