import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_flutter/feature/department/cubit/department_add_cubit.dart';
import 'package:poc_flutter/feature/department/cubit/department_cubit.dart';
import 'package:poc_flutter/feature/department/repository/department_repo.dart';
import 'package:poc_flutter/feature/employee/cubit/employee_add_cubit.dart';
import 'package:poc_flutter/feature/employee/cubit/employee_cubit.dart';
import 'package:poc_flutter/feature/employee/repository/employee_repo.dart';
import 'package:poc_flutter/feature/projects/cubit/projects_add_cubit.dart';
import 'package:poc_flutter/feature/projects/cubit/projects_cubit.dart';
import 'package:poc_flutter/feature/projects/repository/projects_repo.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({super.key, 
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return EmployeeCubit(
              employeeRepository:
                  RepositoryProvider.of<EmployeeRepository>(context),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return EmployeeAddCubit(
              employeeRepository:
                  RepositoryProvider.of<EmployeeRepository>(context),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return DepartmentCubit(
              departmentRepository:
                  RepositoryProvider.of<DepartmentRepository>(context),
            );
          },
        ),
       
        BlocProvider(
          create: (context) {
            return DepartmentAddCubit(
              departmentRepository:
                  RepositoryProvider.of<DepartmentRepository>(context),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return ProjectsAddCubit(
              dataRepository:
                  RepositoryProvider.of<ProjectsRepository>(context),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return ProjectsCubit(
              dataRepository:
                  RepositoryProvider.of<ProjectsRepository>(context),
            );
          },
        ),
      ],
      child: child,
    );
  }
}
