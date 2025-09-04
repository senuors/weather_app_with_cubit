import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:weather_app_with_cubit/models/weather_mode.dart';
import 'package:weather_app_with_cubit/services/api_services.dart';

part 'weather_state.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(NoWeatherState());

  getWeather({required String cityName}) async {
    emit(WeatherLoadingState());

    try {
      WeatherModel? weatherModel = await ApiServices(
        Dio(),
      ).getCurrentWeather(cityName);

      emit(WeatherLoadedState(weatherModel!));
    } catch (e) {
      emit(WeatherFailureState());
    }
  }
}
