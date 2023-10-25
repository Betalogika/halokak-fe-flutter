import 'package:hive/hive.dart';

part 'account_model.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<String>? roles;
  @HiveField(3)
  Map<String, dynamic>? role;
  @HiveField(4)
  String? token;

  Account({ required this.id, this.name, this.role, this.roles, this.token});

  factory Account.from(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      name: json['username'],
      role: json['role'],
      roles: json['roles'] != null ? List.from(json['roles']) : null,
      token: json['token'],
    );
  }
}