import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/settings_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/weather_cubit.dart';
import 'settings_screen.dart';
import 'widgets/search_widget.dart';
import 'widgets/weather_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherCubit weatherCubit = BlocProvider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter pogodynka"),
          actions: [
            IconButton(
              onPressed: () {
                context.read<ThemeCubit>().updateTheme(null); // clear theme
                weatherCubit.setInitialState(); // remove state weather
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute( // new page
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<SettingsCubit>(context),
                      child: const SettingsScreen(), // settings
                    ),
                  ),
                ),
              },
              icon: const Icon(Icons.settings),
            )
          ],
        ),
        body: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoaded) {
              context.read<ThemeCubit>().updateTheme(state.weather);
            } else if (state is WeatherError) {
              var snackBar = SnackBar(
                content: Text(state.message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.white)),
              ); // create error message
              ScaffoldMessenger.of(context).showSnackBar(snackBar); // show errors
            }
          },
          builder: ((context, state) {
            if (state is WeatherInitial) {
              return SearchWidget(); // home page
            } else if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator()); // Loading circular
            } else if (state is WeatherLoaded) {
              return WeatherWidget(state.weather, () { // return weather page
                return context
                    .read<WeatherCubit>()
                    .refreshWeather(state.weather.city); // anonymous function to refresh
              });
            } else {
              // (state is WeatherError)
              return SearchWidget();
            }
          }),
        ));
  }
}
