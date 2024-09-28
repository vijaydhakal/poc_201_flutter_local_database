import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_flutter/feature/employee/cubit/employee_cubit.dart';
import 'package:poc_flutter/feature/employee/ui/widget/employee_list_widget.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  void initState() {
    context.read<EmployeeCubit>().fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const EmployeeListWidget();
  }
}
