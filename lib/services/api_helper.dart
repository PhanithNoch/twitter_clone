import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:twitter_clone/models/user_login_res_model.dart';

class APIHelper {
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
      if (res.statusCode == 200) {
        return UserLoginResModel.fromJson(res.data);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e.toString());
    }
  }
}
