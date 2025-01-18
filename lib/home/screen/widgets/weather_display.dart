import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/home/screen/weather_display_screen.dart';

import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_state.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherDetailsScreen(state: state),
              ),
            );
          });
          return const SizedBox.shrink();
        } else if (state is WeatherError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
