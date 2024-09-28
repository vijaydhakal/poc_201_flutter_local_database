import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_flutter/common/widget/error/no_data_widget.dart';
import 'package:poc_flutter/common/widget/item_delete_dialog.dart';
import 'package:poc_flutter/feature/employee/cubit/employee_add_cubit.dart';
import 'package:poc_flutter/feature/employee/cubit/employee_cubit.dart';
import 'package:poc_flutter/feature/employee/model/employee.dart';
import 'package:poc_flutter/feature/employee/ui/widget/employee_add_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:poc_flutter/app/theme.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/navigation/nav.dart';
import 'package:poc_flutter/common/util/size_utils.dart';
import 'package:poc_flutter/common/widget/app_bar/build_appbar.dart';
import 'package:poc_flutter/common/widget/button/button_with_leading_icon.dart';
import 'package:poc_flutter/common/widget/loading_overlay.dart';
import 'package:poc_flutter/common/widget/shimmer/common_list_shimmer.dart';
import 'package:poc_flutter/common/widget/toast.dart';

class EmployeeListWidget extends StatefulWidget {
  const EmployeeListWidget({super.key});

  @override
  State<EmployeeListWidget> createState() => _EmployeeListWidgetState();
}

class _EmployeeListWidgetState extends State<EmployeeListWidget> {
  final RefreshController refreshController = RefreshController();

  bool isLoadMoreActive = false;
  bool _isLoading = false;

  _loadMore(BuildContext context) {
    context.read<EmployeeCubit>().fetchData();
  }

  _turnOffloading() {
    isLoadMoreActive = false;
    _isLoading = false;
    setState(() {});
  }

  _onDelete(BuildContext ctx, Employee item) {
    showDialog<dynamic>(
      context: context,
      builder: (_) {
        return ItemDeleteDialog(
            onTrue: (val) {
              if (val == true) {
                ctx.read<EmployeeAddCubit>().deleteEmployee(
                      id: item.id ?? 0,
                    );
              }
            },
            isLoading: _isLoading);
      },
    );
  }

  _onEdit(BuildContext ctx, Employee item) {
    NavigationService.push(AddEmployeeWidget(item: item));
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ButtonWithLeadingIcon(
            textColor: Colors.white,
            borderColor: CustomTheme.black,
            name: "Add Employee",
            width: 40.w,
            icon: Icons.add,
            function: () {
              //add employee
              NavigationService.push(const AddEmployeeWidget());
            },
            backgroundColor: Colors.black,
            iconColor: Colors.white),
        appBar: buildAppBar(
          "Employees",
          bgColor: Colors.white,
          actions: [
            //make cart icon widget
          ],
        ),
        body: BlocConsumer<EmployeeAddCubit, DataState>(
          listener: (context, st) {
            if (st is StateDataSuccess) {
              _loadMore(context);
            }
          },
          builder: (context, st) {
            return BlocConsumer<EmployeeCubit, DataState>(
              buildWhen: (context, state) {
                if (state is StateLoading) {
                  return false;
                } else {
                  return true;
                }
              },
              listener: (context, state) {
                if (state is StateLoadingMoreData) {
                  if (isLoadMoreActive == false) {
                    isLoadMoreActive = true;
                    setState(() {});
                  }
                }
                if (state is StateDataFetchSuccess || state is StateNoData) {
                  _turnOffloading();
                }
                if (state is StateError) {
                  _turnOffloading();
                  CustomToast.error(message: state.message);
                }
                if (state is StatePaginationNoMoreData) {
                  _turnOffloading();
                }
              },
              builder: (context, state) {
                if (state is StateLoading) {
                  return const CommonListShimmer();
                } else if (state is StateError) {
                  return Center(
                    child: Text(
                      state.message,
                    ),
                  );
                } else if (state is StateDataFetchSuccess ||
                    state is StateRefreshingData ||
                    state is StateLoadingMoreData ||
                    state is StatePaginationNoMoreData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Department')),
                          DataColumn(label: Text('Salary')),
                          DataColumn(label: Text('Project')),
                          DataColumn(label: Text('Assignment Status')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: (state.data as List<Employee>)
                            .map(
                              (employee) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                      Text(employee.id?.toString() ?? 'N/A')),
                                  DataCell(Text(employee.name)),
                                  DataCell(
                                      Text(employee.departmentName ?? 'N/A')),
                                  DataCell(Text(employee.salary)),
                                  DataCell(Text(employee.projectName ?? 'N/A')),
                                  DataCell(Text(employee.assignmentStatus)),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _onEdit(context, employee);
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _onDelete(context, employee);
                                        },
                                        icon: const Icon(Icons.delete),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                } else if (state is StateNoData) {
                  return const Center(child: NoDataWidget());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
