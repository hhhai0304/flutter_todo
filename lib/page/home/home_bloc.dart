import 'package:bloc/bloc.dart';

//region EVENT
abstract class HomeEvent {}

class LoadHome extends HomeEvent {}
//endregion

//region STATE
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
//  final List<Home> homes;
//
//  HomeLoaded(this.homes);
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
//endregion

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(event) async* {
    if (event is LoadHome) {
      yield* _mapLoadHomeToState(event);
    }
  }

  Stream<HomeState> _mapLoadHomeToState(LoadHome event) async* {}
}
