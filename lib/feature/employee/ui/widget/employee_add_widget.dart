import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/widget/form_validators.dart';
import 'package:poc_flutter/common/util/check_empty_utils.dart';
import 'package:poc_flutter/common/util/size_utils.dart';
import 'package:poc_flutter/common/widget/app_bar/build_appbar.dart';
import 'package:poc_flutter/common/widget/button/rounded_filled_button.dart';
import 'package:poc_flutter/common/widget/comon_input_textfield.dart';
import 'package:poc_flutter/common/widget/custom_dropdown.dart';
import 'package:poc_flutter/common/widget/loading_overlay.dart';
import 'package:poc_flutter/common/widget/toast.dart';
import 'package:poc_flutter/feature/department/cubit/department_cubit.dart';
import 'package:poc_flutter/feature/department/model/department.dart';
import 'package:poc_flutter/feature/employee/cubit/employee_add_cubit.dart';
import 'package:poc_flutter/feature/employee/cubit/employee_cubit.dart';
import 'package:poc_flutter/feature/employee/model/employee.dart';
import 'package:poc_flutter/feature/projects/cubit/projects_cubit.dart';
import 'package:poc_flutter/feature/projects/model/project.dart';

class AddEmployeeWidget extends StatefulWidget {
 final Employee? item;

  const AddEmployeeWidget({super.key, this.item});

  @override
  State<AddEmployeeWidget> createState() => _AddEmployeeWidgetState();
}

class _AddEmployeeWidgetState extends State<AddEmployeeWidget> {
  int? projectId;
  int? departmentId;

  String? selectedDepartment;
  String? selectedProject;

  final _nameController = TextEditingController();
  final _salaryController = TextEditingController();
  final _assignmentStatusController = TextEditingController();

  bool _isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  void initState() {
    super.initState();

    context.read<DepartmentCubit>().fetchData();
    context.read<ProjectsCubit>().fetchData();

    if (widget.item != null) {
      _nameController.text = widget.item!.name;
      _salaryController.text = widget.item!.salary.toString();
      _assignmentStatusController.text = widget.item!.assignmentStatus;
      projectId = widget.item!.projectId;
      departmentId = widget.item!.departmentId;
      selectedDepartment = widget.item!.departmentName;
      selectedProject = widget.item!.projectName;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _salaryController.dispose();
    _assignmentStatusController.dispose();
  }

  void _onAdd() {
    FocusScope.of(context).unfocus();

    bool validated = _formkey.currentState!.validate();
    if (validated) {
      Map<String, dynamic> body = {
        "name": _nameController.text,
        "department_id": departmentId,
        "salary": _salaryController.text,
        "project_id": projectId,
        "assignment_status": _assignmentStatusController.text
      };
      if (widget.item != null) {
        context
            .read<EmployeeAddCubit>()
            .updateEmployee(id: widget.item!.id ?? 0, employee: body);
      } else {
        context.read<EmployeeAddCubit>().addEmployee(employee: body);
      }
    } else {
      CustomToast.error(message: "Please complete the form");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(""),
      body: SafeArea(
        top: true,
        child: LoadingOverlay(
          isLoading: _isLoading,
          child: BlocListener<EmployeeAddCubit, DataState>(
            listener: (context, state) {
              if (state is StateLoading) {
                _isLoading = true;
                setState(() {});
              }
              if (state is StateDataSuccess) {
                _isLoading = false;

                setState(() {});
                context.read<EmployeeCubit>().fetchData();
                CustomToast.success(message: "Data Inserted");
                Navigator.pop(context);
              } else if (state is StateError) {
                setState(() {});
                CustomToast.error(message: state.message);

                _isLoading = false;
              }
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 26.wp),
              child: Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Gap(30.wp),
                    InputFormTextfieldWithLabel(
                      hintText: "Enter Name",
                      controller: _nameController,
                      labelText: " Name",
                      validationFunction: (val) =>
                          FormValidator.validateEmptyString(
                              _nameController.text, "Name"),
                    ),
                    InputFormTextfieldWithLabel(
                      hintText: "Enter Salary",
                      controller: _salaryController,
                      labelText: " Salary",
                      validationFunction: (val) =>
                          FormValidator.validateEmptyString(
                              _nameController.text, "Salary"),
                    ),
                    InputFormTextfieldWithLabel(
                      hintText: "Enter Status",
                      controller: _assignmentStatusController,
                      labelText: " Status",
                      validationFunction: (val) =>
                          FormValidator.validateEmptyString(
                              _nameController.text, "Status"),
                    ),
                    BlocBuilder<DepartmentCubit, DataState>(
                      builder: (BuildContext context, st) {
                        if (st is StateLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (st is StateDataFetchSuccess) {
                          final List<String> departmentNameList =
                              (st.data as List<Department>)
                                  .map((Department element) =>
                                      element.departmentName)
                                  .toList();

                          return CustomDropDown(
                            items: departmentNameList,
                            borderRadius: 20,
                            hintText: "Select Department",
                            onChanged: (String? val) {
                              selectedDepartment = val;
                              departmentId = (st.data as List<Department>)
                                  .firstWhere((element) =>
                                      element.departmentName == val)
                                  .id;
                            },
                            selected: selectedDepartment,
                            validator: (String? val) {
                              if (CheckEmptyUtils.checkEmpty(val)) {
                                return "Select Department";
                              } else {
                                return null;
                              }
                            },
                            title: "Department",
                          );
                        }
                        return Container();
                      },
                    ),
                    BlocBuilder<ProjectsCubit, DataState>(
                      builder: (BuildContext context, st) {
                        if (st is StateLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (st is StateDataFetchSuccess) {
                          final List<String> projectNameList =
                              (st.data as List<Project>)
                                  .map((Project element) => element.projectName)
                                  .toList();

                          return CustomDropDown(
                            items: projectNameList,
                            borderRadius: 20,
                            hintText: "Select Project",
                            onChanged: (String? val) {
                              selectedProject = val;
                              projectId = (st.data as List<Project>)
                                  .firstWhere(
                                      (element) => element.projectName == val)
                                  .id;
                            },
                            selected: selectedProject,
                            validator: (String? val) {
                              if (CheckEmptyUtils.checkEmpty(val)) {
                                return "Select Project";
                              } else {
                                return null;
                              }
                            },
                            title: "Project",
                          );
                        }
                        return Container();
                      },
                    ),
                    Gap(30.wp),
                    RoundedFilledButton(
                        textColor: Colors.white,
                        onPressed: () {
                          _onAdd();
                        },
                        verticalPadding: 20,
                        title: (widget.item != null) ? "Edit" : "Add",
                        backgroundColor: Colors.black,
                        borderColor: Colors.white),
                    Gap(30.wp),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
