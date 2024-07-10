import 'package:flutter/cupertino.dart';
import 'package:flutter_with_node_1/common/methods/show_toast.dart';
import 'package:flutter_with_node_1/features/dashboard/models/todo_model.dart';
import 'package:flutter_with_node_1/utils/api/api.dart';
import 'package:flutter_with_node_1/utils/api/rest_api.dart';
import 'package:flutter_with_node_1/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DashboardController extends GetxController {
  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDescriptionController = TextEditingController();
  final RestAPI restAPI = Get.find<RestAPI>();
  late final String userId;

  TextEditingController todoUpdateTitleController = TextEditingController();
  TextEditingController todoUpdateDescriptionController = TextEditingController();

  final RxList<ToDoModel> todoModelList = <ToDoModel>[].obs;
  final RxBool isFetchingTodos = false.obs;
  late final MLocalStorage localStorage;

  @override
  void onInit() {
    super.onInit();

    localStorage = Get.find<MLocalStorage>();
    Map<String, dynamic> jwtDecodedToken =
        JwtDecoder.decode(localStorage.getToken() ?? "");
    userId = jwtDecodedToken['_id'];
  }

  void clearController() {
    todoTitleController.clear();
    todoDescriptionController.clear();
    todoUpdateTitleController.clear();
    todoUpdateDescriptionController.clear();
  }

  /// Add Todo List
  void addTodo() async {
    try {
      if (todoTitleController.text.isNotEmpty &&
          todoDescriptionController.text.isNotEmpty) {
        var response =
            await restAPI.postDataMethod(APIConstants.strAddToDo, data: {
          "userId": userId,
          "title": todoTitleController.text,
          "description": todoDescriptionController.text,
        }, headers: {
          'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
        });
        if (response == null || response?.isEmpty) {
          showToast(title: "addTodo Response is Null or Empty");
          return;
        }
        if (response['status'] == "success") {
          showToast(title: "addTodo Successful");
        } else {
          showToast(title: response.error.toString());
        }
      }
    } catch (error) {
      showToast(title: error.toString());
    }
  }

  /// Fetch Todo List Of User
  Future<void> getToDoList() async {
    try {
      isFetchingTodos.value = true;
      var response = await restAPI.getDataMethod(
        APIConstants.strGetToDoList,
        data: {
          "userId": userId,
        },
      );

      if (response == null || response?.isEmpty) {
        showToast(title: "getToDoList Response is Null or Empty");
        isFetchingTodos.value = false;
        return;
      }
      if (response['status'] == "success") {
        print("into success");
        todoModelList.clear(); // Clear the list before adding new items

        print("response['todoListData'] ==>  ${response['todoListData']}");
        print("response['todoListData'] ==>  ${response}");
        for (var listData in response['todoListData']) {
          print(
              "ToDoModel.fromJson(listData) == > ${ToDoModel.fromJson(listData)}");
          ToDoModel model = ToDoModel.fromJson(listData);
          todoModelList.add(model);
        }
        print("Parsed Todo List: $todoModelList"); // Debugging print
        print("userId ===> $userId");
        showToast(title: "getToDoList Successful");
      } else {
        showToast(title: response.error.toString());
      }
    } catch (e) {
      showToast(title: e.toString());
    } finally {
      isFetchingTodos.value = false;
    }
  }

  /// Fetch Todo List Of User
  Future<void> getToDoListPost() async {
    try {
      isFetchingTodos.value = true;
      var response =
          await restAPI.postDataMethod(APIConstants.strGetToDoList, data: {
        "userId": userId,
      }, headers: {
        'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
      });

      if (response == null || response?.isEmpty) {
        showToast(title: "getToDoListPost Response is Null or Empty");
        isFetchingTodos.value = false;
        return;
      }
      if (response['status'] == "success") {
        todoModelList.clear(); // Clear the list before adding new items

        print("response['todoListData'] ==>  ${response['todoListData']}");
        print("response['todoListData'] ==>  ${response}");
        for (var listData in response['todoListData']) {
          print(
              "ToDoModel.fromJson(listData) == > ${ToDoModel.fromJson(listData)}");
          ToDoModel model = ToDoModel.fromJson(listData);
          todoModelList.add(model);
        }
        print("Parsed Todo List: $todoModelList"); // Debugging print
        print("userId ===> $userId");
        // showToast(title: "getToDoListPost Successful");
      } else {
        showToast(title: response.error.toString());
      }
    } catch (e) {
      showToast(title: e.toString());
    } finally {
      isFetchingTodos.value = false;
    }
  }

  /// Update Todo
  Future<void> updateTodo({
    required String todoId,
    required String title,
    required String description,
  }) async {
    try {
      var response = await restAPI.postDataMethod(APIConstants.strUpdateToDo, data: {
        "todoId": todoId,
        "title": title,
        "description": description
      }, headers: {
        'Authorization': "Bearer ${localStorage.getToken() ?? ''}"
      });

      if (response == null || response?.isEmpty) {
        showToast(title: "updateTodo Response is Null or Empty");
        return;
      }

      if (response['status'] == "success") {
        showToast(title: "Todo Updated Successfully");
        getToDoListPost();

        // Update the local list of todos
        int index = todoModelList.indexWhere((todo) => todo.id == todoId);
        if(index != -1){
          todoModelList[index].title = title;
          todoModelList[index].description = description;
          update(); // Refresh the UI
        }
      } else {
        showToast(title: response['msg'].toString());
      }

    } catch (e) {
      showToast(title: e.toString());
    }
  }
}
