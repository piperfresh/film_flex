abstract class ApiProviderRepository<T> {
  Future<T?> get(
      String string, {
        Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? body,
        Map<String, dynamic>? headers,
        String? token,
        // BuildContext? context,
      }) async {
    return null;
  }

  Future<T?> post(
      String string, {
        Map<String, dynamic>? queryParameter,
        Map<String, dynamic>? body,
        Map<String, dynamic>? headers,
        String? token,
      }) async {
    return null;
  }
}