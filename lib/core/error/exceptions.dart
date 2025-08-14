class ServerException implements Exception {
  final String message;
  final String? code;

  ServerException(this.message, {this.code});
}

class CacheException implements Exception {
  final String message;
  final String? code;

  CacheException(this.message, {this.code});
}

class NetworkException implements Exception {
  final String message;
  final String? code;

  NetworkException(this.message, {this.code});
}
