import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/models/dream.dart';

class DreamService {
  static final Map<String, Dream> _dreamsById = {};

  static List<Dream> getAllMyDreams() {
    return _dreamsById.values.toList();
  }

// create chat
//   final item = DreamChat(
// 		text: "Lorem ipsum dolor sit amet",
// 		dreamID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d");
// await Amplify.DataStore.save(item);

// delete
//await Amplify.DataStore.delete(toDeleteItem);

// query
// final item = DreamChat(
// 		text: "Lorem ipsum dolor sit amet",
// 		dreamID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d");
// await Amplify.DataStore.save(item);

  static Future<void> createDream(String subject, String summary) async {
    try {
      final item =
          Dream(title: "Lorem ipsum dolor sit amet", userID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d", conversation: []);
      await Amplify.DataStore.save(item);
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
    final item =
        Dream(title: "Lorem ipsum dolor sit amet", userID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d", conversation: []);
    final updatedItem = item.copyWith(
        title: "Lorem ipsum dolor sit amet", userID: "a3f4095e-39de-43d2-baf4-f8c16f0f6f4d", conversation: []);
    await Amplify.DataStore.save(updatedItem);

    // final request = ModelMutations.update(updatedModel);
    // final response = await Amplify.API.mutate(request: request).response;
    // print('Response: $response');
  }

  static Future<List<Dream?>> queryListItems() async {
    try {
      List<Dream> items = await Amplify.DataStore.query(Dream.classType);
      for (Dream dream in items) {
        _dreamsById[dream.id] = dream;
      }
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return <Dream?>[];
  }
}
