import 'package:bloc/bloc.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/feature/department/repository/department_repo.dart';

class DepartmentCubit extends Cubit<DataState> {
  DepartmentCubit({required this.departmentRepository}) : super(StateInitial());
  final DepartmentRepository departmentRepository;

  //fetch data from database
  fetchData() async {
    emit(StateLoading());
    final res = await departmentRepository.fetchData();
    if (res.status == Status.Success && res.data!.isNotEmpty) {
      emit(StateDataFetchSuccess(data: res.data!));
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }

    if (res.status == Status.Success && res.data!.isEmpty) {
      emit(const StateNoData());
    }
  }
}
