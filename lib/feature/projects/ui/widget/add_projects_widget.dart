import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/form_validators.dart';
import 'package:poc_flutter/common/util/size_utils.dart';
import 'package:poc_flutter/common/widget/app_bar/build_appbar.dart';
import 'package:poc_flutter/common/widget/button/rounded_filled_button.dart';
import 'package:poc_flutter/common/widget/comon_input_textfield.dart';
import 'package:poc_flutter/common/widget/loading_overlay.dart';
import 'package:poc_flutter/common/widget/toast.dart';
import 'package:poc_flutter/feature/projects/cubit/projects_add_cubit.dart';
import 'package:poc_flutter/feature/projects/cubit/projects_cubit.dart';

class AppProjectsWidget extends StatefulWidget {
  const AppProjectsWidget({super.key});

  @override
  State<AppProjectsWidget> createState() => _AppProjectsWidgetState();
}

class _AppProjectsWidgetState extends State<AppProjectsWidget> {
  final _departmentNameController = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _departmentNameController.dispose();
  }

  void _onAdd() {
    FocusScope.of(context).unfocus();

    bool validated = _formkey.currentState!.validate();
    if (validated) {
      Map<String, dynamic> body = {
        "project_name": _departmentNameController.text,
      };
      context.read<ProjectsAddCubit>().addData(data: body);
    } else {
      CustomToast.error(message: "Please enter project name");
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
          child: BlocListener<ProjectsAddCubit, DataState>(
            listener: (context, state) {
              if (state is StateLoading) {
                _isLoading = true;
                setState(() {});
              }
              if (state is StateDataSuccess) {
                _isLoading = false;

                setState(() {});
                context.read<ProjectsCubit>().fetchData();
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
                      hintText: "Enter Projects Name",
                      controller: _departmentNameController,
                      labelText: "Projects Name",
                      validationFunction: (val) =>
                          FormValidator.validateEmptyString(
                              _departmentNameController.text, "Projects Name"),
                    ),
                    Gap(30.wp),
                    RoundedFilledButton(
                        textColor: Colors.white,
                        onPressed: () {
                          _onAdd();
                        },
                        verticalPadding: 20,
                        title: "Add",
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
