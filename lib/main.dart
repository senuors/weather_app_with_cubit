import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_cubit/screens/start_page.dart';

import 'cubit/weather_cubit.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WeatherApp',
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.orange[200], elevation: 3),
          scaffoldBackgroundColor: Colors.lightBlue[50],
        ),
        home: StartPage(),
      ),
    );
  }
}
