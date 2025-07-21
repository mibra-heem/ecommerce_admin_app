import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConst {
  const ApiConst._();

  // Request Methods
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE';

  // static const baseUrl = 'http://192.168.18.86:8000';
  static String baseUrl = dotenv.env['BASE_URL'] ?? '';

  // Banner Api's
  static const bannersUrl = '/api/admin/banners';

  // Category Api's
  static const categoriesUrl = '/api/admin/categories';

  // Product Api's
  static const productsUrl = '/api/admin/products';
}
