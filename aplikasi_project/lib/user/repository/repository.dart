import 'dart:convert';

import 'package:aplikasi_project/user/model/user_model.dart';
import 'package:dio/dio.dart';

class Repository {
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  final dio = Dio();

  Future<List<PostModel>> fetchUser() async {
    final response = await dio.get('$baseUrl/posts');

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw Exception('failed to load post');
    }
  }
}
