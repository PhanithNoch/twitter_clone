import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:twitter_clone/models/post_res_model.dart';
import 'dart:io';

import 'package:twitter_clone/models/user_login_res_model.dart';

class APIHelper {
  final box = GetStorage();

  final _dio = Dio();
  // final _baseUrl = "http://localhost:8000/api";
  final _baseUrl = "http://192.168.0.156:8000/api";
  Future<bool> register({
    required String email,
    required String name,
    required String password,
    File? profile,
  }) async {
    try {
      var _formData = FormData.fromMap({
        "email": email,
        "name": name,
        "password": password,
        "c_password": password,
        "profile":
            profile != null ? await MultipartFile.fromFile(profile.path) : null,
      });

      final res = await _dio.post(
        "$_baseUrl/register",
        data: _formData,
        options: Options(
          headers: {
            "Accept": "application/json",
          },
          followRedirects: false,
          validateStatus: (status) => status! <= 500,
        ),
      );
      if (res.statusCode == 200) {
        return true;
      }
      if (res.statusCode == 500) {
        throw Exception("email already exists");
      }
      return false;
      // throw Exception(res.data['message']);
    } catch (e) {
      debugPrint(e.toString());

      throw Exception(e.toString());
    }
  }

  Future<UserLoginResModel?> login(
      {required String email, required String password}) async {
    try {
      final res = await _dio.post(
        "$_baseUrl/login",
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            "Accept": "application/json",
          },
          followRedirects: false,
          validateStatus: (status) => status! <= 500,
        ),
      );
      print("res $res");
      if (res.statusCode == 200) {
        return UserLoginResModel.fromJson(res.data);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<bool> createPost({
    required String caption,
    File? photo,
  }) async {
    print("caption $caption");
    print("photo $photo");
    print("token ${box.read("token")}");
    final token = box.read("token");
    try {
      var _formData = FormData.fromMap({
        "caption": caption,
        "image": await MultipartFile.fromFile(
          photo!.path,
        ),
      });

      final res = await _dio.post(
        "$_baseUrl/posts",
        data: _formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (res.statusCode == 200) {
        return true;
      }
      return false;
      // throw Exception(res.data['message']);
    } catch (e) {
      print("error $e");

      throw Exception(e.toString());
    }
  }

  Future<PostResModel> getAllPosts() async {
    final token = box.read("token");

    try {
      final res = await _dio.get(
        "$_baseUrl/posts",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );
      if (res.statusCode == 200) {
        return PostResModel.fromJson(res.data);
      }
      throw Exception(res.data['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> likeDisLike(int postId) async {
    final token = box.read("token");
    try {
      final res = await _dio.post(
        "$_baseUrl/posts/${postId}/likes",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );
      if (res.statusCode == 200) {
        return true;
      }
      throw Exception(res.data['message']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
