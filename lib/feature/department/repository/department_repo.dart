import 'package:poc_flutter/common/db/database_helper.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/common/util/log.dart';
import 'package:poc_flutter/feature/department/model/department.dart';

class DepartmentRepository {
  DepartmentRepository({required this.databaseHelper});

  /// The helper class for performing database operations.
  final DatabaseHelper databaseHelper;

  List<Department> department = [];

  void setData(List<Department> _department) => department = _department;


  List<Department> get getAllData => department;

  Future<DataResponse<List<Department>>> fetchData() async {
    try {
      final res = await databaseHelper.getAllDepartments();

      final _data = await res
          .map((doc) => Department.fromMap(doc as Map<String, dynamic>))
          .toList();
      setData(_data);
      return DataResponse.success(_data);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<int>> insertData(Map<String, dynamic> item) async {
    try {
      final res = await databaseHelper.insertDepartment(item);
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
      final res = await databaseHelper.deleteDepartment(id);
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
