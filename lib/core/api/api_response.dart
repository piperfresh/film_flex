class ApiResponse {
  final int? statusCode;
  final dynamic data;
  final Map<String, dynamic>? headers;

  ApiResponse({this.statusCode, this.data, this.headers});

  @override
  String toString(){
    return '$data';
  }
}
