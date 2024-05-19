import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/story.dart';
import '../services/hacker_news_service.dart';

class StoryController extends GetxController {
  final HackerNewsService _hackerNewsService = HackerNewsService();

  var topStories = <Story>[].obs;
  var latestStories = <Story>[].obs;
  var searchResults = <Story>[].obs;
  var isLoading = false.obs;
  var isDetailLoading = false.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    fetchTopStories();
    fetchLatestStories();
    super.onInit();
  }

  void fetchTopStories() async {
    isLoading.value = true;
    try {
      final ids = await _hackerNewsService.fetchTopStoriesIds();
      final stories = await Future.wait(
          ids.take(50).map((id) => _hackerNewsService.fetchStory(id)));
      topStories.assignAll(stories);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch top stories',
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void fetchLatestStories() async {
    isLoading.value = true;
    try {
      final ids = await _hackerNewsService.fetchLatestStoriesIds();
      final stories = await Future.wait(
          ids.take(50).map((id) => _hackerNewsService.fetchStory(id)));
      latestStories.assignAll(stories);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch latest stories',
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchStories(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    var allStories = [...topStories, ...latestStories];
    var filteredStories = allStories
        .where(
            (story) => story.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    searchResults.assignAll(filteredStories);
  }

  void startLoadingDetail() {
    isDetailLoading.value = true;
    hasError.value = false;
  }

  void finishLoadingDetail() {
    isDetailLoading.value = false;
  }

  void setDetailError() {
    isDetailLoading.value = false;
    hasError.value = true;
  }
}
