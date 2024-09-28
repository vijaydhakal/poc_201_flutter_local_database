import 'package:bloc/bloc.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/feature/department/repository/department_repo.dart';

class DepartmentAddCubit extends Cubit<DataState> {
  DepartmentAddCubit({required this.departmentRepository}) : super(StateInitial());
  final DepartmentRepository departmentRepository;

  //fetch data from database
  addData({required Map<String, dynamic> data}) async {
    emit(StateLoading());
    final res = await departmentRepository.insertData(data);
    if (res.status == Status.Success) {
      emit(StateDataSuccess());
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }
  }

   deleteData({required int id}) async {
    emit(StateLoading());
    final res = await departmentRepository.deleteData(id);
    if (res.status == Status.Success) {
      emit(StateDataSuccess());
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }
  }
  
}
