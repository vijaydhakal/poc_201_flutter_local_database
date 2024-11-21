import 'package:bloc/bloc.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/feature/employee/repository/employee_repo.dart';

class EmployeeAddCubit extends Cubit<DataState> {
  EmployeeAddCubit({required this.employeeRepository}) : super(StateInitial());
  final EmployeeRepository employeeRepository;

  addEmployee({required Map<String, dynamic> employee}) async {
    emit(StateLoading());
    final res = await employeeRepository.insertEmployee(employee);
    if (res.status == Status.Success) {
      emit(StateDataSuccess());
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }
  }

  updateEmployee(
      {required int id, required Map<String, dynamic> employee}) async {
    emit(StateLoading());
    final res = await employeeRepository.updateEmployee(id, employee);
    if (res.status == Status.Success) {
      emit(StateDataSuccess());
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }
  }

  deleteEmployee({required int id}) async {
    emit(StateLoading());
    final res = await employeeRepository.deleteEmployee(id);
    if (res.status == Status.Success) {
      emit(StateDataSuccess());
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }
  }
}
