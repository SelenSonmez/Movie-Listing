import 'dart:convert';

import '../models/content.dart';
import 'package:http/http.dart' as http;

class MovieApiClient {
  static const baseURL = "https://api.themoviedb.org/3/movie/";
  static const apiKey = "5fc88a6d2e9cb86eee88330ef9ae3c6c";
  Future<List<Content>> fetchPopular() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey"));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)['results'] as List;
      List<Content> popularContents = List<Content>.from(
          decodedData.map((model) => Content.fromJson(model)));
      print("popular" + popularContents[0].movieName);

      return popularContents;
    } else {
      throw Exception("Error fetching popular movies");
    }
  }

  Future<List<Content>> fetchNowPlaying() async {
    final response =
        await http.get(Uri.parse("$baseURL/now_playing?api_key=$apiKey"));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)['results'] as List;
      List<Content> nowPlayings = List<Content>.from(
          decodedData.map((model) => Content.fromJson(model)));
      print("NowPlaying" + nowPlayings[0].movieName);

      return nowPlayings;
    } else {
      throw Exception("Error fetching popular movies");
    }
  }

  Future<List<Content>> fetchUpcoming() async {
    final response =
        await http.get(Uri.parse("$baseURL/upcoming?api_key=$apiKey"));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)['results'] as List;
      List<Content> upcomings = List<Content>.from(
          decodedData.map((model) => Content.fromJson(model)));
      print("upcoming" + upcomings[0].movieName);
      return upcomings;
    } else {
      throw Exception("Error fetching popular movies");
    }
  }
}
