import 'package:notey/api/endPoints.dart';
import 'package:notey/api/remote/auth_api.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/taskModel.dart';

class HomeRepository {

  Future<TaskModel> getTasks() async {
    final response = await sl<HttpAuth>().getData(
      url: Endpoints.tasks,
    );
    TaskModel taskModel = TaskModel.fromJson(response.data);

    if (taskModel.status == true) {
      return taskModel;
    }
    throw '${taskModel.message}';
  }


  Future<TaskModel> addTask(String title) async {
    final response = await sl<HttpAuth>().postData(
      url: Endpoints.tasks,
      data: {"title": title}
    );
    TaskModel taskModel = TaskModel.fromJson(response.data);

    if (taskModel.status == true) {
      return taskModel;
    }
    throw '${taskModel.message}';
  }


  Future<TaskModel> deleteTask(int id) async {
    final response = await sl<HttpAuth>().deleteData(
        url: Endpoints.tasks+"/$id",

    );
    TaskModel taskModel = TaskModel.fromJson(response.data);

    if (taskModel.status == true) {
      return taskModel;
    }
    throw '${taskModel.message}';
  }


  Future<TaskModel> updateTask(int id,String title) async {
    final response = await sl<HttpAuth>().putData(
      data: {"title": title},
      url: Endpoints.tasks+"/$id",

    );
    TaskModel taskModel = TaskModel.fromJson(response.data);

    if (taskModel.status == true) {
      return taskModel;
    }
    throw '${taskModel.message}';
  }
}
