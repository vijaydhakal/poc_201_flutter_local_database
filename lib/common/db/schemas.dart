// ignore_for_file: public_member_api_docs

import 'package:poc_flutter/common/db/storage_constants.dart';
import 'package:poc_flutter/common/db/table.dart';

/// This class is responsible for creating the 'employees' table and related fields
final employeeTable = Table(
  tableName: StorageConstants.employeeTable,
  createTableQuery: '''
    CREATE TABLE ${StorageConstants.employeeTable} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      department_id INTEGER,
      salary REAL,
      project_id INTEGER,
      assignment_status TEXT,
      FOREIGN KEY (department_id) REFERENCES departments(id),
      FOREIGN KEY (project_id) REFERENCES projects(id)
    )
  ''',
);

final departmentTable = Table(
  tableName: StorageConstants.departmentTable,
  createTableQuery: '''
    CREATE TABLE ${StorageConstants.departmentTable} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      department_name TEXT NOT NULL
    )
  ''',
);

final projectTable = Table(
  tableName: StorageConstants.projectTable,
  createTableQuery: '''
    CREATE TABLE ${StorageConstants.projectTable} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      project_name TEXT NOT NULL
    )
  ''',
);

final projectAssignmentTable = Table(
  tableName: StorageConstants.projectAssignmentTable,
  createTableQuery: '''
    CREATE TABLE ${StorageConstants.projectAssignmentTable} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      employee_id INTEGER NOT NULL,
      project_id INTEGER NOT NULL,
      status TEXT,
      FOREIGN KEY (employee_id) REFERENCES employees(id),
      FOREIGN KEY (project_id) REFERENCES projects(id)
    )
  ''',
);
