import 'package:flutter/material.dart';

// import 'counter/app.dart' as Counter;

// import 'timer/app.dart' as Timer;

import 'package:bloc/bloc.dart';
import 'infinite_list/bloc/delegate.dart';
import 'infinite_list/app.dart' as InfiniteList;

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(InfiniteList.App());
}
