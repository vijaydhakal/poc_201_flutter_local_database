import 'package:bloc/bloc.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/feature/employee/repository/employee_repo.dart';

class EmployeeCubit extends Cubit<DataState> {
  EmployeeCubit({required this.employeeRepository}) : super(StateInitial());
  final EmployeeRepository employeeRepository;

  //fetch data from database
  fetchData() async {
    emit(StateLoading());
    final res = await employeeRepository.fetchEmployee();
    if (res.status == Status.Success && res.data!.isNotEmpty) {
      emit(StateDataFetchSuccess(data: res.data!));
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }

    if (res.status == Status.Success && res.data!.isEmpty) {
      emit(const StateDataFetchSuccess(data: []));
    }
  }
}
