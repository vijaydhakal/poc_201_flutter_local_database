import 'package:poc_flutter/common/db/schemas.dart';

class DbMigrations {
  static List<dynamic> version = [
    employeeTable.createTableQuery,
    departmentTable.createTableQuery,
    projectTable.createTableQuery,
    projectAssignmentTable.createTableQuery,
  ];
}
