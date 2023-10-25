import 'package:halokak_app/data/local/text_storage.dart';

class ErrorModel {
  String message;

  ErrorModel({ required this.message });

  factory ErrorModel.from({required Map<String, dynamic> json, String defaultMessage = TextStorage.errorSystem}) {
    return ErrorModel(
      message: json['message'] ?? defaultMessage,
    );
  }
}

enum ErrorExceptionCode {
  connectionTimeout(1),
  requestTimeout(2),
  socket(3);
  const ErrorExceptionCode(this.value);
  final int value;
}

class ErrorException implements Exception {
  String message;
  String prefix;
  int code;

  ErrorException(this.message, {this.prefix = "", this.code = 0});

  @override
  String toString() {
    return "$prefix$message";
  }
}