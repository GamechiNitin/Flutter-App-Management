import 'dart:convert';
import 'dart:developer';

import 'package:superbike_app/features/posts/model/posts_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  static Future<List<PostsModel>?> fetchPost() async {
    var client = http.Client();
    try {
      List<PostsModel> posts = [];

      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/'),
      );
      List covert = jsonDecode(response.body);
      for (int i = 0; i < covert.length; i++) {
        PostsModel post =
            PostsModel.fromJson(covert[i] as Map<String, dynamic>);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
