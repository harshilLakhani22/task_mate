// To parse this JSON data, do
//
//     final toDoModel = toDoModelFromJson(jsonString);

import 'dart:convert';

List<ToDoModel> toDoModelFromJson(String str) => List<ToDoModel>.from(json.decode(str).map((x) => ToDoModel.fromJson(x)));

String toDoModelToJson(List<ToDoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToDoModel {
  String id;
  String userId;
  String title;
  String description;
  int v;

  ToDoModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.v,
  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "title": title,
    "description": description,
    "__v": v,
  };
}
