import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_flutter/common/bloc/multi_bloc_wrapper.dart';
import 'package:poc_flutter/common/constant/env.dart';
import 'package:poc_flutter/common/db/database_helper.dart';
import 'package:poc_flutter/feature/department/repository/department_repo.dart';
import 'package:poc_flutter/feature/employee/repository/employee_repo.dart';
import 'package:poc_flutter/feature/projects/repository/projects_repo.dart';

class MultiRepositoryProviderListing extends StatelessWidget {
  final Widget child;
  final Env env;
  const MultiRepositoryProviderListing(
      {super.key, required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
          lazy: true,
        ),
        RepositoryProvider<DepartmentRepository>(
          create: (context) => DepartmentRepository(
            databaseHelper: DatabaseHelper()
          ),
          lazy: true,
        ),
        RepositoryProvider<EmployeeRepository>(
          create: (context) => EmployeeRepository(
            databaseHelper: DatabaseHelper()
          ),
          lazy: true,
        ),
        RepositoryProvider<ProjectsRepository>(
          create: (context) => ProjectsRepository(
            databaseHelper: DatabaseHelper()
          ),
          lazy: true,
        ),
      ],
      child: MultiBlocWrapper(child: child),
    );
  }
}

class InternetCheck {}
