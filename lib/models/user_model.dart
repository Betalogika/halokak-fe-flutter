import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0, defaultValue: "")
  String id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  List<String>? roles;

  User({ required this.id, this.name, this.roles});

  factory User.from(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? "",
      name: json['name'],
      roles: json['role'] != null ? List.from(json['role']) : null,
    );
  }
}