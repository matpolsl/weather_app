import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'cubit/settings_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'cubit/weather_cubit.dart';
import 'data/repository/weather_repository.dart';
import 'view/main_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory()); // init storage
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  ); // run app
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( // inits cubits
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(WeatherRepository(http.Client())),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(), // background color
        ),
      ],
      child: const WeatherApp(),
    );
  }
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, MaterialColor>(builder: (context, color) {
      return BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
        return MaterialApp(
          title: 'Flutter pogodynka',
          theme: ThemeData(
            primarySwatch: color,
            textTheme: state.accessibility
                ? const TextTheme( //senior mode = text size x1.5
                    headline1: TextStyle(fontSize: 96 * 1.5),
                    headline2: TextStyle(fontSize: 60 * 1.5),
                    subtitle1: TextStyle(fontSize: 16 * 1.5),
                    subtitle2: TextStyle(fontSize: 14 * 1.5),
                    button: TextStyle(fontSize: 14 * 1.5),
                    headline3: TextStyle(
                        fontSize: 48 * 1.5, color: Colors.black), // City-name
                    headline4: TextStyle(
                        fontSize: 34 * 1.5, color: Colors.black), // Temperature
                    headline5: TextStyle(
                        fontSize: 32 * 1.5,
                        color: Colors.black), // sun icon
                    headline6: TextStyle(fontSize: 20 * 1.5), // description
                    bodyText1: TextStyle(
                        fontSize: 16 * 1.5, fontWeight: FontWeight.normal),
                    bodyText2: TextStyle(fontSize: 14 * 1.5), // sun time
                  )
                : const TextTheme( // normal mode
                    headline3: TextStyle(
                        fontSize: 48, color: Colors.black), // City-name
                    headline4: TextStyle(
                        fontSize: 34, color: Colors.black), // Temperature
                    headline5: TextStyle(
                        fontSize: 32, color: Colors.black), // sun icon
                    headline6: TextStyle(fontSize: 20), // description
                    bodyText1:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    bodyText2: TextStyle(fontSize: 14), // sun time
                  ),
          ),
          home: MainScreen(),
        );
      });
    });
  }
}
