import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:weatherapp/models/weathers_details.dart';
import 'package:weatherapp/repositories/weather_repositories.dart';

part 'weathers_state.dart';

class WeathersCubit extends Cubit<WeathersState> {
  final WeatherRepository weatherRepository;
  WeathersCubit(this.weatherRepository) : super(WeathersInitial());

  Future<void> getCityWeatherDetails() async {
    var details;
    emit(WeathersLoading());
    try {
      details = await weatherRepository.getCurrentLocation();
      emit(WeathersLoaded(weatherDetails: details));
    } catch (e) {
      emit(WeathersFailure(message: e.toString()));
    }
    print(details);
  }

  Future<void> changeStateToInit() async {
    emit(WeathersInitial());
    print("emitted");
  }
}
