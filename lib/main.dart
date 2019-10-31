import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'timer/bloc/bloc.dart';
// import 'timer/bloc/ticker.dart';
// import 'timer/timer.dart';

import 'counter/counter_bloc.dart';
import 'counter/counter_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<CounterBloc>(
        builder: (context) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Color.fromRGBO(109, 234, 255, 1),
//         accentColor: Color.fromRGBO(72, 74, 126, 1),
//         brightness: Brightness.dark,
//       ),
//       title: 'Flutter Timer',
//       home: BlocProvider(
//         builder: (context) => TimerBloc(ticker: Ticker()),
//         child: Timer(),
//       ),
//     );
//   }
// }
