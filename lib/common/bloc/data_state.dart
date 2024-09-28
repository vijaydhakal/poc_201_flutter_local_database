// ignore_for_file: overridden_fields

import 'package:equatable/equatable.dart';

class DataState extends Equatable {
  final dynamic data;
  const DataState({this.data, this.filterId});
  final String? filterId;
  @override
  List<Object?> get props => [data, filterId];
}

class StateInitial extends DataState {}

class StateLoading extends DataState {}

class StateDummyLoading extends DataState {}

class StateError extends DataState {
  final String message;
  const StateError({required this.message});
  @override
  List<Object?> get props => [message];
}

class StateNoData extends DataState {
  @override
  final dynamic data;
  const StateNoData({this.data});
  @override
  List<Object?> get props => [data];
}

class StateDataFetchSuccess extends DataState {
  @override
  final List data;
  const StateDataFetchSuccess({required this.data}) : super(data: data);
  @override
  List<Object?> get props => [...data];
}

class StateDataFetchSuccessMap extends DataState {
  @override
  final List data;
  @override
  final String filterId;
  const StateDataFetchSuccessMap({required this.data, required this.filterId})
      : super(data: data, filterId: filterId);
  @override
  List<Object?> get props => [data, filterId];
}

class StateRefreshingData extends DataState {
  @override
  final List data;
  const StateRefreshingData({required this.data});
  @override
  List<Object?> get props => [...data];
}

class StateLoadingMoreData extends DataState {
  @override
  final List data;
  const StateLoadingMoreData({required this.data}) : super(data: data);
  @override
  List<Object?> get props => [...data];
}

class StatePaginationNoMoreData extends DataState {
  @override
  final List data;
  const StatePaginationNoMoreData({required this.data}) : super(data: data);
  @override
  List<Object?> get props => [...data];
}

class StateLoadingMoreDataMap extends DataState {
  @override
  final List data;
  @override
  final String filterId;
  const StateLoadingMoreDataMap({required this.data, required this.filterId})
      : super(data: data, filterId: filterId);
  @override
  List<Object?> get props => [data, filterId];
}

class StateDataLoading extends DataState {
  @override
  List<Object?> get props => [];
}

class StateDataError extends DataState {
  @override
  List<Object?> get props => [];
}

class StateDataSuccess extends DataState {
  @override
  List<Object?> get props => [];
}
