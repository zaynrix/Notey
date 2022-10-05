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

  int? id = 0;
  bool? init;

  bool loading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> ScaffoldKeySheet = GlobalKey();
  GlobalKey<ScaffoldState> ScaffoldKeySheet1 = GlobalKey();
  TextEditingController noteTitle = TextEditingController();

  List<Data>? tasks = [];

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
      loading = true;
      notifyListeners();
      try {
        TaskModel taskModel =
            await sl<HomeRepository>().addTask(noteTitle.text);
        tasks!.add(taskModel.singleData!);
      } on DioError catch (e) {
        AppConfig().showException(e);
      }

      id = 0;
      loading = false;
      noteTitle.clear();
      sl<NavigationService>().pop();
      notifyListeners();
    }
  }

  // ------------------ Delete Task ------------------

  Future deleteTask() async {
    loading = true;
    notifyListeners();
    try {
      TaskModel taskModel = await sl<HomeRepository>().deleteTask(id!);
      if (taskModel.status == true) {
        tasks!.removeWhere((i) => i.id == id);
        getHome();
        loading = false;
        notifyListeners();
      } else {
        AppConfig.showSnakBar("${taskModel.message}", Success: false);
      }
    } on DioError catch (e) {
      init = false;
      loading = false;
      notifyListeners();
      AppConfig().showException(e);
    }
    noteTitle.clear();
    id = 0;
    notifyListeners();
  }

  // ------------------ Update Task ------------------

  Future updateTask() async {
    loading = true;
    notifyListeners();
    try {
      TaskModel taskModel =
          await sl<HomeRepository>().updateTask(id!, noteTitle.text);
      if (taskModel.status == true) {
        getHome();
        loading = false;
        notifyListeners();

        // Second Way

        // tasks!.forEach(
        //   (element) {
        //     id == element.id ? element.title = noteTitle.text : "";
        //   },
        // );
      }
    } on DioError catch (e) {
      loading = false;
      notifyListeners();
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
