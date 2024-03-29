import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets.dart';
import '../blocs/blocs.dart';

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CitySelection(),
                ),
              );
              if (city != null) {
                BlocProvider.of<WeatherBloc>(context)
                    .add(FetchWeather(city: city));
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoaded) {
              BlocProvider.of<ThemeBloc>(context).add(
                WeatherChanged(condition: state.weather.condition),
              );
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherEmpty) {
                return Center(child: Text('Please Select a Location'));
              }
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherLoaded) {
                final weather = state.weather;

                return RefreshIndicator(
                  onRefresh: () {
                    BlocProvider.of<WeatherBloc>(context).add(
                      RefreshWeather(city: state.weather.location),
                    );
                    return _refreshCompleter.future;
                  },
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 100.0),
                        child: Center(
                          child: Location(location: weather.location),
                        ),
                      ),
                      Center(
                        child: LastUpdated(dateTime: weather.lastUpdated),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 50.0),
                        child: Center(
                          child: CombinedWeatherTemperature(
                            weather: weather,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is WeatherError) {
                return Text(
                  'Something went wrong!',
                  style: TextStyle(color: Colors.red),
                );
              }
              return Container(
                width: 0,
                height: 0,
              );
            },
          ),
        ),
      ),
    );
  }
}
