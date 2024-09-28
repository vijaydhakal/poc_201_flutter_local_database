import 'package:bloc/bloc.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/feature/projects/repository/projects_repo.dart';

class ProjectsAddCubit extends Cubit<DataState> {
  ProjectsAddCubit({required this.dataRepository}) : super(StateInitial());
  final ProjectsRepository dataRepository;

  //fetch data from database
  addData({required Map<String, dynamic> data}) async {
    emit(StateLoading());
    final res = await dataRepository.insertData(data);
    if (res.status == Status.Success) {
      emit(StateDataSuccess());
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }
  }

   deleteData({required int id}) async {
    emit(StateLoading());
    final res = await dataRepository.deleteData(id);
    if (res.status == Status.Success) {
      emit(StateDataSuccess());
    }

    if (res.status == Status.Error) {
      emit(StateError(message: res.message!));
    }
  }
  
}
