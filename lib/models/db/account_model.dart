import 'package:hive/hive.dart';

part 'account_model.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0, defaultValue: "")
  String id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<String>? roles;

  Account({ required this.id, this.name, this.roles});

  factory Account.from(Map<String, dynamic> json) {
    return Account(
      id: json['id'] ?? "",
      name: json['name'],
      roles: json['role'] != null ? List.from(json['role']) : null,
    );
  }
}