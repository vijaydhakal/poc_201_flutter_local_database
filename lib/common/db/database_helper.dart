import 'package:path/path.dart';
import 'package:poc_flutter/common/db/migrations.dart';
import 'package:poc_flutter/common/db/schemas.dart';
import 'package:poc_flutter/common/db/storage_constants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'company.db');
    return await openDatabase(path,
        version: DbMigrations.version.length + 1,
        onCreate: _onCreate,
        onConfigure: _onConfigure,
        onUpgrade: (db, oldVersion, newVersion) async {
      for (var i = oldVersion - 1; i <= newVersion - 2; i++) {
        // ignore: avoid_dynamic_calls
        if (DbMigrations.version[i].runtimeType != String) {
          for (final j in DbMigrations.version[i]) {
            await db.execute(j);
          }
        } else {
          await db.execute(DbMigrations.version[i]);
        }
      }
    });
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    await db
      ..execute(employeeTable.createTableQuery)
      ..execute(departmentTable.createTableQuery)
      ..execute(projectTable.createTableQuery)
      ..execute(projectAssignmentTable.createTableQuery);
  }

  static Future _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute('PRAGMA foreign_keys = ON');
  }
  // CRUD operations for Employees

  // Create a new employee
  Future<int> insertEmployee(Map<String, dynamic> employee) async {
    final db = await database;
    return await db.insert(
      StorageConstants.employeeTable,
      employee,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all employees with their department and project names using JOINs
  Future<List<Map<String, dynamic>>> getAllEmployees() async {
    final db = await database;
    return await db.rawQuery('''
    SELECT e.id, e.name, d.department_name, e.salary, p.project_name, e.assignment_status 
    FROM ${StorageConstants.employeeTable} e
    LEFT JOIN ${StorageConstants.departmentTable} d ON e.department_id = d.id
    LEFT JOIN ${StorageConstants.projectTable} p ON e.project_id = p.id
  ''');
  }

  // Update employee details
  Future<int> updateEmployee(int id, Map<String, dynamic> employee) async {
    final db = await database;
    return await db.update(
      StorageConstants.employeeTable,
      employee,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete an employee
  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete(
      StorageConstants.employeeTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD operations for Departments

  // Insert a new department
  Future<int> insertDepartment(Map<String, dynamic> department) async {
    final db = await database;
    return await db.insert(
      StorageConstants.departmentTable,
      department,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteDepartment(int id) async {
    final db = await database;
    return await db.delete(
      StorageConstants.departmentTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get all departments
  Future<List<Map<String, dynamic>>> getAllDepartments() async {
    final db = await database;
    return await db.query(StorageConstants.departmentTable);
  }

  // CRUD operations for Projects

  // Insert a new project
  Future<int> insertProject(Map<String, dynamic> project) async {
    final db = await database;
    return await db.insert(
      StorageConstants.projectTable,
      project,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteProject(int id) async {
    final db = await database;
    return await db.delete(
      StorageConstants.projectTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get all projects
  Future<List<Map<String, dynamic>>> getAllProjects() async {
    final db = await database;
    return await db.query(StorageConstants.projectTable);
  }

  // CRUD operations for Project Assignments

  // Insert a new project assignment
  Future<int> insertProjectAssignment(
      Map<String, dynamic> projectAssignment) async {
    final db = await database;
    return await db.insert(
      StorageConstants.projectAssignmentTable,
      projectAssignment,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all project assignments for an employee
  Future<List<Map<String, dynamic>>> getProjectAssignments(
      int employeeId) async {
    final db = await database;
    return await db.query(
      StorageConstants.projectAssignmentTable,
      where: 'employee_id = ?',
      whereArgs: [employeeId],
    );
  }

  // Update project assignment
  Future<int> updateProjectAssignment(
      int id, Map<String, dynamic> assignment) async {
    final db = await database;
    return await db.update(
      StorageConstants.projectAssignmentTable,
      assignment,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete project assignment
  Future<int> deleteProjectAssignment(int id) async {
    final db = await database;
    return await db.delete(
      StorageConstants.projectAssignmentTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
