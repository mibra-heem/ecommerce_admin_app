class DatasourceUtils {
  DatasourceUtils._();

  static String joinIds({required String userId, required String chatId}) {
    final ids = [userId, chatId]..sort();
    return ids.join('_');
  }

  static String getUrlWithId ({
    required String url,
    required int id,
  }){
    return '$url/$id';
  }
}
