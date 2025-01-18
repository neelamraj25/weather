import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/home/screen/widgets/custom.dart';
import '../../bloc/weather_bloc.dart';
import '../../bloc/weather_event.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = context.read<WeatherBloc>();
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownSearch<String>(
              popupProps: PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  hintText: 'Select locations',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  prefixIcon:
                      const Icon(Icons.location_on, color: Colors.white),
                ),
              ),
              items: (filter, infiniteScrollProps) => predefinedLocations,
              dropdownBuilder: (context, selectedItem) {
                return Text(
                  selectedItem ?? '',
                  style: const TextStyle(color: Colors.white),
                );
              },
              onChanged: (value) {
                if (value != null) {
                  weatherBloc.add(FetchWeather(value));
                }
              },
              selectedItem: null,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.my_location, color: Colors.white),
            label: const Text(
              'Use Current Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.black38,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
            onPressed: () {
              weatherBloc.add(FetchWeatherByCurrentLocation());
            },
          ),
        ],
      ),
    );
  }
}
