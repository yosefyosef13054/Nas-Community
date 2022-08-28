import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/todo/todo.dart';
import 'package:nas_academy/core/utils/api.dart';

class TodoApi {
  Future<List<Todo>> getTodoOriantation(communityId) async {
    try {
      String token = await UserLocalDB.getToken();
      http.Response response = await http.get(API.toDoCommunityID(communityId), headers: API.header(token));
      final decoded = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> list = List.from(decoded ?? []);
        return list.map((e) => Todo.fromJson(e)).toList();
      } else {
        throw ServerError<TodoApi>(
            title: "Failed to get Todo", body: decoded["message"]);
      }
    } catch (e) {
      log("ERROR getting Todos : ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> completeTask(taskID, iscomplete) async {
    try {
      String token = await UserLocalDB.getToken();
      final body = jsonEncode({"completed": iscomplete});
      http.Response response = await http.put(API.toDoTaskID(taskID),
          headers: API.header(token), body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerError<TodoApi>(
            title: "Failed to get communities", body: response.toString());
      }
    } catch (e) {
      log("ERROR getting LiveSession : ${e.toString()}");
      rethrow;
    }
  }
}
