import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/models/ModelProvider.dart';
import 'package:dream_catcher/services/user_service.dart';
import 'package:flutter/material.dart';

class DreamService extends ChangeNotifier {
  final UserService _userService = getIt<UserService>();
  static final Map<String, Dream> _dreamsById = {};

  List<Dream>? getAllMyDreams() {
    return _dreamsById.values.toList();
  }

  Future<List<Dream?>> fetchUserDreams() async {
    try {
      final request = ModelQueries.list(Dream.classType);
      final response = await Amplify.API.query(request: request).response;

      final dreams = response.data?.items;
      if (dreams == null) {
        print('errors: ${response.errors}');
        return <Dream?>[];
      }
      for (Dream? dream in dreams) {
        if (dream == null) continue;
        _dreamsById[dream.id] = dream;
      }
      notifyListeners();
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return <Dream?>[];
  }

  Future<String?> createOrUpdateDream(
    String? dreamId,
    String title,
  ) async {
    String? dreamId;
    if (dreamId == null) {
      dreamId = await createDream(title);
      return dreamId;
    } else {
      bool result = await updateDream(dreamId, title);
      if (result) {
        return dreamId;
      }
      return null;
    }
  }

  Future<String?> createDream(String title) async {
    try {
      String? userId = await _userService.retrieveCurrentUserId();
      if (userId == null) {
        safePrint('User ID is null');
        return null;
      }
      final dream = Dream(
        title: title,
        userID: userId,
      );
      final request = ModelMutations.create(dream);
      final response = await Amplify.API.mutate(request: request).response;

      final createdDream = response.data;
      if (createdDream == null) {
        safePrint('errors: ${response.errors}');
        return null;
      }
      safePrint('Mutation result: ${createdDream.title}');
      _dreamsById[createdDream.id] = createdDream;
      notifyListeners();
      return createdDream.id;
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      return null;
    }
  }

  Future<bool> updateDream(String dreamId, String title) async {
    try {
      String? userId = await _userService.retrieveCurrentUserId();
      if (userId == null) {
        safePrint('User ID is null');
        return false;
      }

      final dream = Dream(
        id: dreamId,
        title: title,
        userID: userId,
      );
      final request = ModelMutations.update(dream);
      final response = await Amplify.API.mutate(request: request).response;

      final updatedDream = response.data;
      if (updatedDream == null) {
        safePrint('errors: ${response.errors}');
        return false;
      }
      safePrint('Mutation result: ${updatedDream.title}');
      _dreamsById[updatedDream.id] = updatedDream;
      notifyListeners();
      safePrint('Response: $response');
      return true;
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      return false;
    }
  }

  // for if we get to a bunch of dreams
  static const limit = 100;
  Future<List<Dream?>> queryPaginatedListItems() async {
    final firstRequest = ModelQueries.list<Dream>(Dream.classType, limit: limit);
    final firstResult = await Amplify.API.query(request: firstRequest).response;
    final firstPageData = firstResult.data;

    // Indicates there are > 100 todos and you can get the request for the next set.
    if (firstPageData?.hasNextResult ?? false) {
      final secondRequest = firstPageData!.requestForNextResult;
      final secondResult = await Amplify.API.query(request: secondRequest!).response;
      return secondResult.data?.items ?? <Dream?>[];
    } else {
      return firstPageData?.items ?? <Dream?>[];
    }
  }
}
