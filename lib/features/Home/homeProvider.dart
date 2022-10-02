import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notey/api/local/local_pref.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/taskModel.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/repository/home_repo/task_repo.dart';
import 'package:notey/shared/widgets/CustomeBottomSheet.dart';

class HomeProvider extends ChangeNotifier {
  bool loading = false;
  bool init = true;
  int? id = 0;
  GlobalKey<ScaffoldState> sheetScafoldKey = GlobalKey();
  TextEditingController noteTitle= TextEditingController();

  List<Data>? tasks = [];




  Future<void> getHome() async {
    init = false;
    try {
      TaskModel taskModel = await sl<HomeRepository>().getTasks();
      tasks = taskModel.data;

      if (tasks!.isEmpty) {
        init = true;
      }
    } on DioError catch (e) {
      init = false;
      notifyListeners();
      AppConfig().showException(e);
    }
    notifyListeners();
  }

  Future<void> addTask() async {
    print("note Title ${noteTitle.text}");
    loading = true;
    notifyListeners();
    try {
      TaskModel taskModel = await sl<HomeRepository>().addTask(noteTitle.text);
      tasks!.add(taskModel.singleData!);
      loading = false;
      notifyListeners();
    } on DioError catch (e) {
      init = false;
      AppConfig().showException(e);
      loading = false;
    }
    sl<NavigationService>().pop();
    id = 0;
    noteTitle.clear();
    notifyListeners();
  }

  Future<void> deleteTask() async {
    loading = true;
    notifyListeners();
    try {
      await sl<HomeRepository>().deleteTask(id!);
      tasks!.removeWhere((i) => i.id == id);
    } on DioError catch (e) {
      AppConfig().showException(e);
    }
    init = false;
    loading = false;
    noteTitle.clear();
    id = 0;
    notifyListeners();
  }

  Future<void> updateTask() async {
    loading = true;
    notifyListeners();
    try {
      await sl<HomeRepository>().updateTask(id!, noteTitle.text);
      tasks!.forEach(
        (element) {
          id == element.id ? element.title = noteTitle.text : "";
          notifyListeners();
          loading = false;
          notifyListeners();
        },
      );
    } on DioError catch (e) {
      AppConfig().showException(e);
    }
    init = false;
    loading = false;
    id = 0;
    sl<NavigationService>().pop();
    noteTitle.clear();
    notifyListeners();
  }

  refresh() async {
    tasks!.clear();
    getHome();
    notifyListeners();
  }

  languageSheet() {
    id == 0 ? 0 : id;
    id == 0 ? noteTitle.clear() : noteTitle;
    print("This id $id");
    print("Lang ${noteTitle.text}");
    showModalBottomSheet(
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: ColorManager.darkGrey,
      context: sheetScafoldKey.currentContext!,
      builder: (context) => BottomSheetNote(),
    );
  }
}
