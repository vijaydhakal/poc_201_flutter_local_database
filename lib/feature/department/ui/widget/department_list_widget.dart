import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_flutter/common/navigation/nav.dart';
import 'package:poc_flutter/common/widget/common_list_view.dart';
import 'package:poc_flutter/common/widget/error/no_data_widget.dart';
import 'package:poc_flutter/common/widget/item_delete_dialog.dart';
import 'package:poc_flutter/feature/department/cubit/department_add_cubit.dart';
import 'package:poc_flutter/feature/department/cubit/department_cubit.dart';
import 'package:poc_flutter/feature/department/model/department.dart';
import 'package:poc_flutter/feature/department/ui/widget/add_department_widget.dart';
import 'package:poc_flutter/feature/department/ui/widget/department_item_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:poc_flutter/app/theme.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/util/size_utils.dart';
import 'package:poc_flutter/common/widget/app_bar/build_appbar.dart';
import 'package:poc_flutter/common/widget/button/button_with_leading_icon.dart';
import 'package:poc_flutter/common/widget/loading_overlay.dart';
import 'package:poc_flutter/common/widget/shimmer/common_list_shimmer.dart';
import 'package:poc_flutter/common/widget/toast.dart';

class DepartmentListWidget extends StatefulWidget {
  const DepartmentListWidget({super.key});

  @override
  State<DepartmentListWidget> createState() => _DepartmentListWidgetState();
}

class _DepartmentListWidgetState extends State<DepartmentListWidget> {
  final RefreshController refreshController = RefreshController();

  bool _isLoadMoreEnabled = true;
  bool isLoadMoreActive = false;
  bool _isLoading = false;

  _loadMore(BuildContext context) {
    context.read<DepartmentCubit>().fetchData();
  }

  _turnOffloading() {
    isLoadMoreActive = false;
    _isLoading = false;
    setState(() {});
  }

  _onDelete(BuildContext ctx, Department item) {
    showDialog<dynamic>(
      context: context,
      builder: (_) {
        return ItemDeleteDialog(
            onTrue: (val) {
              if (val == true) {
                ctx.read<DepartmentAddCubit>().deleteData(
                      id: item.id ?? 0,
                    );
              }
            },
            isLoading: _isLoading);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: ButtonWithLeadingIcon(
            textColor: Colors.white,
            borderColor: CustomTheme.black,
            name: "Add Department",
            width: 40.w,
            icon: Icons.add,
            function: () {
              //add employee
              NavigationService.push(const AppDepartmentWidget());
            },
            backgroundColor: Colors.black,
            iconColor: Colors.white),
        appBar: buildAppBar(
          "Departments",
          bgColor: Colors.white,
          showBackButton: true,
        ),
        body: BlocConsumer<DepartmentAddCubit, DataState>(
          listener: (context, st) {
            if (st is StateDataSuccess) {
              _loadMore(context);
            }
          },
          builder: (context, st) {
            return BlocConsumer<DepartmentCubit, DataState>(
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
                  _isLoadMoreEnabled = false;
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
                  return CommonListview(
                    refreshController: refreshController,
                    items: state.data,
                    onRefresh: () {},
                    loadMore: () => _loadMore(context),
                    itemBuilder: (context, index) {
                      Department item = state.data[index];
                      return DepartmentItemWidget(
                        item: item,
                        onDelete: () => _onDelete(context, item),
                      );
                    },
                    loadMoreEnabled: _isLoadMoreEnabled,
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
