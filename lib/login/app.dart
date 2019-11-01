import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';
import 'authentication/authentication.dart';
import 'loading_indicator.dart';
import 'login_page.dart';
import 'splash_page.dart';

import 'bloc_delegate.dart';
import 'user_repository.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    final userRepository = UserRepository();

    return BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            // if (state is AuthenticationUninitialized) {
            return SplashPage();
            // }
          },
        ),
      ),
    );
  }
}
