import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/weather_cubit.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "🗺",
            style: TextStyle(fontSize: 64),
          ),
          Text(
            "Wyszukaj miasto:",
            style: Theme.of(context).textTheme.headline6,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Miasto"),
            controller: _textController,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  final WeatherCubit weatherCubit = BlocProvider.of(context);
                  weatherCubit.getWeather(_textController.text);
                },
                child: const Text("Wyszukaj")),
          ),
        ],
      ),
    );
  }
}
