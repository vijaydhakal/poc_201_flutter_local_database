import 'package:poc_flutter/common/db/database_helper.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/common/util/log.dart';
import 'package:poc_flutter/feature/projects/model/project.dart';

class ProjectsRepository {
  ProjectsRepository({required this.databaseHelper});

  /// The helper class for performing database operations.
  final DatabaseHelper databaseHelper;

  List<Project> allData = [];

  void setData(List<Project> allData) => allData = allData;


  List<Project> get getAllData => allData;

  Future<DataResponse<List<Project>>> fetchData() async {
    try {
      final res = await databaseHelper.getAllProjects();

      final data = res
          .map((doc) => Project.fromMap(doc))
          .toList();
      setData(data);
      return DataResponse.success(data);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<int>> insertData(Map<String, dynamic> item) async {
    try {
      final res = await databaseHelper.insertProject(item);
      if (res != 0) {
        return DataResponse.success(res);
      }
      return DataResponse.error("Failed to insert data");
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

   Future<DataResponse<int>> deleteData(int id) async {
    try {
      final res = await databaseHelper.deleteProject(id);
      if (res != 0) {
        return DataResponse.success(res);
      }
      return DataResponse.error("Failed to delete data");
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }
}
