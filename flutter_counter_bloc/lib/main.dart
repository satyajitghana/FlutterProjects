import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC Architecture is pretty simple to use
// You basically map Events to States
// the Events come in streams

// 01 Events

/// Events are the input to the bloc, they are commonly dispatched in response
/// to user interactions such as button press or lifecycle event like page loads
///

enum CounterEvent { increment, decrement }

/// Here we are representing the two events in form of a enum but in a complex event
/// we would use a class, so the first thing to think is of the events that take place
/// in your app, here there are only two, either you can increment the counter or decrement it

// 02 States

/// States are the output of the bloc, they represent the application state, UI components
/// can be notified of the states and redraw portions of themselves based on the current
/// state
///
/// As we are only building a simple counter we have only one state that is to be modified
/// the counter itself, here a int would work
///

// 03 BLoC

/// CounterBloc is a bloc that converts CounterEvents into ints
/// Every Bloc has an initial state, here 0

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

// Logging the transition
  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);

    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print('$error, $stacktrace');
  }

// Whenever you use async use yield, async* here means a stream of async
// This is mapping an event to a state
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
      case CounterEvent.decrement:
        yield currentState - 1;
    }
  }
}

/// But how do you notify a bloc of an event ?
/// You use the dispatch method, it takes an event and triggers the mapEventToState

/// Here's How the Transitions will take place
///
// {
//     "currentState": 0,
//     "event": "CounterEvent.increment",
//     "nextState": 1
// }
// {
//     "currentState": 1,
//     "event": "CounterEvent.increment",
//     "nextState": 2
// }
// {
//     "currentState": 2,
//     "event": "CounterEvent.increment",
//     "nextState": 3
// }

// If you want to do something when a transition takes place, then override
// the onTransition method

/// If you want all the transitions in one place then use the BlocDelegate
///

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {

// To access all transitions taking place
/// BlocSupervisor is a Singleton that oversees all the Blocs and delegates responsibilities
/// to the BlocDelegate
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // BlocProvider will make the instance of CounterBloc available to the entire
      // subtree under CounterPage()
      home: BlocProvider(
        builder: (BuildContext context) => CounterBloc(),
        child: CounterPage(title: 'Flutter Counter'),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {

  final String title;

  CounterPage({this.title});

  @override
  Widget build(BuildContext context) {

    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder(
        bloc: _counterBloc,
        builder: (BuildContext context, int state) {
          return Center(
            child: Text(
              '$state',
              style: TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _counterBloc.dispatch(CounterEvent.increment),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () => _counterBloc.dispatch(CounterEvent.decrement),
            ),
          )
        ],
      ),
    );
  }
}
