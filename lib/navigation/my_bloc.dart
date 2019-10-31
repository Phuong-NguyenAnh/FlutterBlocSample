import 'package:bloc/bloc.dart';
import 'bloc.dart';

class MyBloc extends Bloc<MyEvent, ROUTE_STATE> {
  @override
  ROUTE_STATE get initialState => ROUTE_STATE.StateA;

  @override
  Stream<ROUTE_STATE> mapEventToState(MyEvent event) async* {
    switch (event) {
      case MyEvent.eventA:
        yield ROUTE_STATE.StateA;
        break;
      case MyEvent.eventB:
        yield ROUTE_STATE.StateB;
        break;
      case MyEvent.eventC:
        yield ROUTE_STATE.StateC;
        break;
    }
  }
}
