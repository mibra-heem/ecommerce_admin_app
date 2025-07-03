import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
import 'package:ecommerce_admin_app/core/constants/api_const.dart';
import 'package:ecommerce_admin_app/core/errors/exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class BaseApiService {
  Future<SDMap> get({required String url, String? serverAccessToken});
  Future<SDMap> post({
    required String url,
    required SDMap? body,
    File? file,
    String? serverAccessToken,
    bool isMultiPart = false,
    bool needBaseUrl = true,
  });
  Future<SDMap> postMultiPart({
    required String url,
    required SDMap? body,
    required File file,
    required String fieldName,
    String serverAccessToken,
    bool needBaseUrl = true,
  });
  Future<SDMap> put({
    required String url,
    required SDMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  });
  Future<SDMap> delete({
    required String url,
    required SDMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  });
}

class ApiService implements BaseApiService {
  const ApiService({required String baseUrl}) : _baseUrl = baseUrl;

  final String _baseUrl;

  @override
  Future<SDMap> get({required String url, String? serverAccessToken}) async {
    final uri = Uri.parse(_baseUrl + url);

    debugPrint('uri => $_baseUrl$url');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
    );

    try {
      if (response.statusCode == 200) {
        debugPrint('Request was successfull.');

        return jsonDecode(response.body) as SDMap;
      } else {
        throw ServerException(
          message: 'GET request failed.',
          statusCode: response.statusCode,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<SDMap> post({
    required String url,
    required SDMap? body,
    File? file,
    String? fileFieldName,
    bool isMultiPart = false,
    String? serverAccessToken,
    bool needBaseUrl = true,
  }) async {
    final uri = Uri.parse(needBaseUrl ? _baseUrl + url : url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
    );
    try {
      if (response.statusCode == 200) {
        debugPrint('POST request was successfull.');
        debugPrint('Post Request Data => ${response.body}');
        return jsonDecode(response.body) as SDMap;
      } else {
        throw ServerException(
          message: 'POST request failed.',
          statusCode: response.statusCode,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SDMap> postMultiPart({
    required String url,
    required SDMap? body,
    required File file,
    required String fieldName,
    bool isMultiPart = false,
    String? serverAccessToken,
    bool needBaseUrl = true,
  }) async {
    final uri = Uri.parse(needBaseUrl ? _baseUrl + url : url);

    final request = http.MultipartRequest(ApiConst.post, uri);

    debugPrint('POST multipart request object created ....');

    // Add token header
    if (serverAccessToken != null) {
      request.headers['Authorization'] = 'Bearer $serverAccessToken';
    }

    if (body != null) {
      request.fields.addAll(
        body.map((key, value) => MapEntry(key, value.toString())),
      );
      debugPrint('Fields has been added to the request ....');

    }

    // Attach file to the request
    request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));

    debugPrint('Image file has been added to the request ....');

    try {
      final streamedResponse = await request.send();
      debugPrint('MultipartRequest has been sended ....');

      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('MultipartRequest response has been recieved ....');

      if (response.statusCode == 201) {
        debugPrint('POST multipart request was successful.');
        debugPrint(response.body);
        return jsonDecode(response.body) as SDMap;
      } else {
        throw Exception(
          'POST multipart request failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('POST multipart request error: $e');
    }
  }

  @override
  Future<SDMap> put({
    required String url,
    required SDMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  }) async {
    final uri = Uri.parse(needBaseUrl ? _baseUrl + url : url);

    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
    );

    try {
      if (response.statusCode == 200) {
        debugPrint('Request was successfull.');

        return jsonDecode(response.body) as SDMap;
      } else {
        throw ServerException(
          message: 'PUT request failed.',
          statusCode: response.statusCode,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<SDMap> delete({
    required String url,
    required SDMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  }) async {
    final uri = Uri.parse(needBaseUrl ? _baseUrl + url : url);

    final response = await http.delete(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
    );

    try {
      if (response.statusCode == 200) {
        debugPrint('Request was successfull.');

        return jsonDecode(response.body) as SDMap;
      } else {
        throw ServerException(
          message: 'DELETE request failed.',
          statusCode: response.statusCode,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
