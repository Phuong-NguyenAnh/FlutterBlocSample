import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

// import 'counter/app.dart' as Counter;

// import 'timer/app.dart' as Timer;

// import 'infinite_list/bloc/delegate.dart';
// import 'infinite_list/app.dart' as InfiniteList;

// import 'navigation/app.dart';

// import 'login/app.dart';

import 'weather/repositories/repositories.dart';
import 'weather/bloc_delegate.dart';
import 'package:http/http.dart' as http;
import 'weather/app.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(App(weatherRepository: weatherRepository));
}
