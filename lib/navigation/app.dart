import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => MyBloc(),
      child: MaterialApp(
        routes: {
          '/': (context) => PageA(),
          '/pageB': (context) => PageB(),
          '/pageC': (context) => PageC()
        },
        initialRoute: '/',
        // home: BlocBuilder<MyBloc, MyState>(
        //   builder: (context , state) {
        //     switch(state.runtimeType)
        //     {
        //       case StateA:
        //       return PageA();
        //       case StateB:
        //       return PageB();
        //       case StateC:
        //       return PageC();
        //       default: return PageA();
        //     }
        //   }
        // ),
      ),
    );
  }
}

class PageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyBloc, ROUTE_STATE>(
      listener: (context, state) {
        if (state == ROUTE_STATE.StateB) {
          Navigator.of(context).pushNamed('/pageB');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Page A'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Go to PageB'),
            onPressed: () {
              BlocProvider.of<MyBloc>(context).add(MyEvent.eventB);
            },
          ),
        ),
      ),
    );
  }
}

class PageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyBloc, ROUTE_STATE>(
      listener: (context, state) {
        if (state == ROUTE_STATE.StateC) {
          Navigator.of(context).pushNamed('/pageC');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Page B'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Pop'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text('Go to PageC'),
                onPressed: () {
                  BlocProvider.of<MyBloc>(context).add(MyEvent.eventC);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageCState();
}

class PageCState extends State<PageC> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyBloc, ROUTE_STATE>(
      listener: (context, state) {
        if (state == ROUTE_STATE.StateA) {
          Navigator.of(context).pushNamed('/');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Page C'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Pop'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text('Go to PageA'),
                onPressed: () {
                  BlocProvider.of<MyBloc>(context).add(MyEvent.eventA);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
