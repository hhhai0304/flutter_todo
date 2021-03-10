import 'dart:convert';

import 'package:todo_app/core/base_model.dart';

class Todo extends BaseModel {
  String code;
  String description;
  bool status;

  Todo({
    this.code,
    this.description,
    this.status = false,
  });

  Todo copyWith({
    String code,
    String description,
    bool status,
  }) =>
      Todo(
        code: code ?? this.code,
        description: description ?? this.description,
        status: status ?? this.status,
      );

  factory Todo.fromRawJson(String str) => Todo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        code: json["code"],
        description: json["description"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "status": status,
      };
}
