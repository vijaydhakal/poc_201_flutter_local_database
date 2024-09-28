import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_flutter/feature/projects/cubit/projects_cubit.dart';
import 'package:poc_flutter/feature/projects/ui/widget/projects_list_widget.dart';


class ProjectsListPage extends StatefulWidget {
  const ProjectsListPage({super.key});

  @override
  State<ProjectsListPage> createState() => _ProjectsListPageState();
}

class _ProjectsListPageState extends State<ProjectsListPage> {
  @override
  void initState() {
    context.read<ProjectsCubit>().fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProjectsListWidget();
  }
}
