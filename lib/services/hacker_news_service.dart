import 'package:dio/dio.dart';
import '../models/story.dart';

class HackerNewsService {
  final Dio _dio = Dio();
  static const String baseUrl = 'https://hacker-news.firebaseio.com/v0';

  Future<List<int>> fetchTopStoriesIds() async {
    final response = await _dio.get('$baseUrl/topstories.json');
    return List<int>.from(response.data);
  }

  Future<List<int>> fetchLatestStoriesIds() async {
    final response = await _dio.get('$baseUrl/newstories.json');
    return List<int>.from(response.data);
  }

  Future<Story> fetchStory(int id) async {
    final response = await _dio.get('$baseUrl/item/$id.json');
    return Story.fromJson(response.data);
  }
}
