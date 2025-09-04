import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/weather_cubit.dart';
import 'weather_info.dart';

class NoWeatherInfo extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  NoWeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "There is no weather data",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        context.read<GetWeatherCubit>().getWeather(
                          cityName: _controller.text,
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              BlocBuilder<GetWeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is NoWeatherState) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Start searching for a city",
                        style: TextStyle(fontSize: 22, color: Colors.grey),
                      ),
                    );
                  } else if (state is WeatherLoadedState) {
                    return WeatherInfoBody(weather: state.weather);
                  } else if (state is WeatherFailureState) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Failed to fetch weather",
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
