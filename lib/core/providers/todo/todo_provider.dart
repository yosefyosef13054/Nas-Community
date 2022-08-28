import 'package:flutter/material.dart';
import 'package:nas_academy/core/api/todo/todo_api.dart';
import 'package:nas_academy/core/modules/todo/todo.dart';

class TodoProvider extends ChangeNotifier {
  TodoApi api = TodoApi();
  List<Todo> todoTasks = [];
  List<Todo> get gettodoTasks => todoTasks;
  List<Todo> finishedtodoTasks = [];
  List<Todo> get getfinishedtodoTasks => finishedtodoTasks;
  List finishedtodoTasksID = [];
  List get getfinishedtodoTasksID => finishedtodoTasksID;
  bool loading = false;
  bool get getloading => loading;

  late TabController _tabController;
  TabController get tabController => _tabController;

  String error = "";

  set setTabController(TabController value) {
    _tabController = value;
  }

  void init(communityId) async {
    try{
      todoTasks = await api.getTodoOriantation(communityId.toString());
      finishedtodoTasks = todoTasks.where((element) => element.completed == true).toList();
      finishedtodoTasksID = finishedtodoTasks.map((e) => e.id).toList();
      notifyListeners();
    }catch (e){
      error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  void completeTask(Todo item) async {
    bool success = await api.completeTask(item.id, true);
    if (success) {
      finishedtodoTasks.add(item);
      finishedtodoTasksID.add(item.id);
      notifyListeners();
    }
  }

  void unCompleteTask(Todo item) async {
    await api.completeTask(item.id, false);
    finishedtodoTasks.remove(item);
    finishedtodoTasksID.remove(item.id);
    notifyListeners();
  }

  void notify (){
    notifyListeners();
  }


  void dis (){
    todoTasks.clear();
    gettodoTasks.clear();
    finishedtodoTasks.clear();
    loading = false;
    getfinishedtodoTasks.clear();
    getfinishedtodoTasksID.clear();
    notifyListeners();
  }
}
