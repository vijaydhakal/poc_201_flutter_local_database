import 'package:bloc/bloc.dart';
import 'package:poc_flutter/common/bloc/data_state.dart';
import 'package:poc_flutter/common/http/response.dart';
import 'package:poc_flutter/feature/projects/repository/projects_repo.dart';

class ProjectsCubit extends Cubit<DataState> {
  ProjectsCubit({required this.dataRepository}) : super(StateInitial());
  final ProjectsRepository dataRepository;

  //fetch data from database
  fetchData() async {
    emit(StateLoading());
    final res = await dataRepository.fetchData();
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
