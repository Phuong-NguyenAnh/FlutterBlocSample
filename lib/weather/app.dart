import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'widgets/weather.dart';

import 'package:http/http.dart' as http;
import 'bloc_delegate.dart';

import 'package:bloc/bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WeatherRepository _weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
        httpClient: http.Client(),
      ),
    );

    BlocSupervisor.delegate = SimpleBlocDelegate();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          builder: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingsBloc>(
          builder: (context) => SettingsBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themState) {
          return MaterialApp(
            title: 'Flutter Weather',
            theme: themState.theme,
            home: BlocProvider(
              builder: (context) =>
                  WeatherBloc(weatherRepository: _weatherRepository),
              child: Weather(),
            ),
          );
        },
      ),
    );
  }
}
