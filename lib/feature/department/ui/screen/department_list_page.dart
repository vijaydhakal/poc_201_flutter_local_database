import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_flutter/feature/department/cubit/department_cubit.dart';
import 'package:poc_flutter/feature/department/ui/widget/department_list_widget.dart';


class DepartmentListPage extends StatefulWidget {
  const DepartmentListPage({super.key});

  @override
  State<DepartmentListPage> createState() => _DepartmentListPageState();
}

class _DepartmentListPageState extends State<DepartmentListPage> {
  @override
  void initState() {
    context.read<DepartmentCubit>().fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DepartmentListWidget();
  }
}
