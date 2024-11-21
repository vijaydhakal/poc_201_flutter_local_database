import 'package:poc_flutter/common/db/database_helper.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/common/util/log.dart';
import 'package:poc_flutter/feature/employee/model/employee.dart';

class EmployeeRepository {
  EmployeeRepository({required this.databaseHelper});

  /// The helper class for performing database operations.
  final DatabaseHelper databaseHelper;

  List<Employee> employees = [];
  //set categories
  void setEmployee(List<Employee> employees) => employees = employees;

  //get categories
  List<Employee> get getEmployees => employees;

  Future<DataResponse<List<Employee>>> fetchEmployee() async {
    try {
      final res = await databaseHelper.getAllEmployees();

      final data = res.map((doc) => Employee.fromMap(doc)).toList();
      setEmployee(data);
      return DataResponse.success(data);
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<int>> insertEmployee(Map<String, dynamic> item) async {
    try {
      final res = await databaseHelper.insertEmployee(item);
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

  Future<DataResponse<int>> updateEmployee(
      int id, Map<String, dynamic> item) async {
    try {
      final res = await databaseHelper.updateEmployee(id, item);
      if (res != 0) {
        return DataResponse.success(res);
      }
      return DataResponse.error("Failed to update data");
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<int>> deleteEmployee(int id) async {
    try {
      final res = await databaseHelper.deleteEmployee(id);
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
