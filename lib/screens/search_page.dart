import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/weather_cubit.dart';
import 'weather_info.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  bool hasNavigated = false; // لمنع push مكرر

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search City")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter city name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      context.read<GetWeatherCubit>().getWeather(
                        cityName: controller.text,
                      );
                      hasNavigated = false; // إعادة تعيين قبل البحث الجديد
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),

            // مساحة عرض حالة الطقس أو الرسائل
            Expanded(
              child: BlocBuilder<GetWeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WeatherLoadedState) {
                    // الانتقال لصفحة WeatherInfoBody مرة واحدة فقط
                    if (!hasNavigated) {
                      hasNavigated = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                WeatherInfoBody(weather: state.weather),
                          ),
                        );
                      });
                    }
                    return const SizedBox.shrink();
                  } else if (state is WeatherFailureState) {
                    return const Center(
                      child: Text(
                        "Failed to fetch weather",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Enter a city to search",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
