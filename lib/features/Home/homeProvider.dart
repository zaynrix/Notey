import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notey/interceptors/di.dart';
import 'package:notey/models/taskModel.dart';
import 'package:notey/utils/appConfig.dart';
import 'package:notey/routing/navigation.dart';
import 'package:notey/resources/color_manager.dart';
import 'package:notey/repository/home_repo/task_repo.dart';
import 'package:notey/shared/widgets/CustomeBottomSheet.dart';

class HomeProvider extends ChangeNotifier {


  //
  int? id = 0;
  bool? init;
  bool loading = false;

  //
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController noteTitle = TextEditingController();
  GlobalKey<ScaffoldState> ScaffoldKeySheet = GlobalKey();
  GlobalKey<ScaffoldState> ScaffoldKeySheet1 = GlobalKey();
  //
  List<Data>? tasks = [];

  // ------------------ change Loader ------------------

  changeLoader(value) {
    loading = value;
    notifyListeners();
  }

  // ------------------ Get Tasks ------------------

  Future getHome() async {
    init = false;
    try {
      TaskModel taskModel = await sl<HomeRepository>().getTasks();
      tasks = taskModel.data;
      notifyListeners();
      if (tasks!.isEmpty) {
        init = true;
      }
    } on DioError catch (e) {
      init = false;
      notifyListeners();
      AppConfig().showException(e);
    }
  }

  // ------------------ Add Task ------------------

  Future addTask() async {
    if (formKey.currentState!.validate()) {
      try {
        TaskModel taskModel =
            await sl<HomeRepository>().addTask(noteTitle.text);
        tasks!.add(taskModel.singleData!);
        notifyListeners();
      } on DioError catch (e) {
        AppConfig().showException(e);
      }
      id = 0;
      noteTitle.clear();
      sl<NavigationService>().pop();
      notifyListeners();
    }
  }

  // ------------------ Delete Task ------------------

  Future deleteTask() async {
    try {
      TaskModel taskModel = await sl<HomeRepository>().deleteTask(id!);
      if (taskModel.status!) {
        tasks!.removeWhere((i) => i.id == id);
        getHome();
        notifyListeners();
      } else {
        // AppConfig().showException(e);

        AppConfig.showSnakBar("${taskModel.message}", Success: false);
      }
    } on DioError catch (e) {
      init = false;
      notifyListeners();
      AppConfig().showException(e);
    }
    noteTitle.clear();
    id = 0;
    notifyListeners();
  }

  // ------------------ Update Task ------------------

  Future updateTask() async {
    try {
      TaskModel taskModel =
          await sl<HomeRepository>().updateTask(id!, noteTitle.text);
      if (taskModel.status == true) {
        getHome();
        notifyListeners();
      }
    } on DioError catch (e) {
      AppConfig().showException(e);
    }
    id = 0;
    init = false;
    sl<NavigationService>().pop();
    noteTitle.clear();
    notifyListeners();
  }

  // ------------------ Refresh Task ------------------

  refresh() async {
    tasks!.clear();
    getHome();
    notifyListeners();
  }

  // ------------------ Show Language Sheet ------------------

  noteBottomSheet(GlobalKey ScaffoldKeySheet) {
    id == 0 ? 0 : id;
    id == 0 ? noteTitle.clear() : noteTitle;
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: ColorManager.darkGrey,
      context: ScaffoldKeySheet.currentContext!,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: BottomSheetNote(),
      ),
    );
  }
}
