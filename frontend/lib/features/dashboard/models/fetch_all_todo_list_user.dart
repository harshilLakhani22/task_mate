// To parse this JSON data, do

import 'dart:convert';

FetchAllToDoListOfUser fetchAllToDoListOfUserFromJson(String str) => FetchAllToDoListOfUser.fromJson(json.decode(str));

String fetchAllToDoListOfUserToJson(FetchAllToDoListOfUser data) => json.encode(data.toJson());

class FetchAllToDoListOfUser {
  String status;
  String msg;
  List<TodoListDatum> todoListData;

  FetchAllToDoListOfUser({
    required this.status,
    required this.msg,
    required this.todoListData,
  });

  factory FetchAllToDoListOfUser.fromJson(Map<String, dynamic> json) => FetchAllToDoListOfUser(
    status: json["status"],
    msg: json["msg"],
    todoListData: List<TodoListDatum>.from(json["todoListData"].map((x) => TodoListDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "todoListData": List<dynamic>.from(todoListData.map((x) => x.toJson())),
  };
}

class TodoListDatum {
  String id;
  String userId;
  String title;
  String description;
  int v;

  TodoListDatum({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.v,
  });

  factory TodoListDatum.fromJson(Map<String, dynamic> json) => TodoListDatum(
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
