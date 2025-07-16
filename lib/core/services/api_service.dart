import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_admin_app/core/app/utils/typedef.dart';
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
  Future<SDMap> sendMultipartRequest({
    required String method,
    required String url,
    required SDMap? body,
    required List<File> files,
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
  Future<SDMap> patch({
    required String url,
    required SDMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  });
  Future<SDMap> delete({
    required String url,
    SDMap? body,
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
  Future<SDMap> sendMultipartRequest({
    required String method,
    required String url,
    required Map<String, dynamic>? body,
    required List<File> files,
    required String fieldName,
    String? serverAccessToken,
    bool needBaseUrl = true,
  }) async {
    final uri = Uri.parse(needBaseUrl ? _baseUrl + url : url);
    final request = http.MultipartRequest(method, uri);

    // Headers
    if (serverAccessToken != null) {
      request.headers['Authorization'] = 'Bearer $serverAccessToken';
    }

    // Fields
    if (body != null && body.isNotEmpty) {
      request.fields.addAll(
        body.map((key, value) => MapEntry(key, value.toString())),
      );
    }

    // Add files
    for (final file in files) {
      request.files.add(
        await http.MultipartFile.fromPath(fieldName, file.path),
      );
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
        return jsonDecode(response.body) as SDMap;
      }else {
        debugPrint(response.body);

        throw ServerException(
          message: response.toString(),
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
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
  Future<SDMap> patch({
    required String url,
    required SDMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  }) async {
    final uri = Uri.parse(needBaseUrl ? _baseUrl + url : url);

    final response = await http.patch(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverAccessToken',
      },
    );

    try {
      if (response.statusCode == 200) {
        debugPrint('PATCH Request was successfull.');
        debugPrint(response.body);


        return jsonDecode(response.body) as SDMap;
      } else {
        debugPrint(response.body);

        throw ServerException(
          message: 'PATCH request failed.',
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
    SDMap? body,
    String? serverAccessToken,
    bool needBaseUrl = true,
  }) async {
    final uri = Uri.parse(needBaseUrl ? _baseUrl + url : url);

    final response = await http.delete(
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
          message: 'DELETE request failed.',
          statusCode: response.statusCode,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
