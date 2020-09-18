part of 'weathers_cubit.dart';

@immutable
abstract class WeathersState extends Equatable {
  @override
  List<Object> get props => [];
}

class WeathersInitial extends WeathersState {
  WeathersInitial();
}

class WeathersLoading extends WeathersState {
  WeathersLoading();
}

class WeathersLoaded extends WeathersState {
  WeatherDetails weatherDetails;
  WeathersLoaded({this.weatherDetails});

  @override
  List<Object> get props => [weatherDetails];
}

class WeathersFailure extends WeathersState {
  String message;
  WeathersFailure({this.message});
}
