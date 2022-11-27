import 'package:halokak_app/data/local/text_storage.dart';

class ErrorModel {
  String message;

  ErrorModel({ required this.message });

  factory ErrorModel.from(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'] ?? TextStorage.errorSystem,
    );
  }
}