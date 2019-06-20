import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

// What is State ? State is just data that changes over the lifecycle of an app, when STATEFUL data changes
// the UI repaints the our widgets to reflect the new data, the UI is just a visual representation of the
// data. its like calling a function with the state as the input and the UI as the return value,
// function(state) => UI, flutter will call this function when you rebuild your widgets

void main() => runApp(MyHomePage2());

// Creating this to display the widget
class DisplayCounter extends StatelessWidget {
  final int _counterVal;
  final Function _updateCounter;
  final String _managementType;

  DisplayCounter(this._managementType, this._counterVal, this._updateCounter);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management',
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: Text(_managementType),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counterVal',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _updateCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          )),
    );
  }
}

// Default State Management

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/////////////////////////////////////////////// End of the Default State Management

// 01. Stateful Widget

// This comes with a setState method which when called, repaints the widget, this will
// run the build method and repaint all it's descendents

// Stateful Widget can have only immutable properties
class MyHomePage2 extends StatefulWidget {
  createState() => _MyHomePage2State();
}

// State can contain Mutable properties
class _MyHomePage2State extends State<MyHomePage2> {
  int _counter = 0; // <-- the stateful data that will change

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisplayCounter('Stateful Widget', _counter, _incrementCounter);
  }
}

/////////////////////////////////////////////////////////// End of Stateful Widget

// 02. Stateful Builder

// To above the boiler plate code in StatefulWidget and then connecting the State with a
// Stateless Widget, we use a StatefulBuilder, in a StatelessWidget, the StatefulBuilder
// gives the setState function, which can be called to change the state of the Widget.

class MyHomePage3 extends StatelessWidget {
  // Only Problem is that we are violating the fact that StatelessWidgets must have
  // immutable properties only
  int _counter = 0; // <--- counter here is mutable

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, StateSetter setState) => DisplayCounter(
          'Stateful Builder', _counter, () => setState(() => _counter++)),
    );
  }
}

//////////////////////////////////////////////// End of StatefulBuilder

// Global or Shared State

// 03. Inherited Widget

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Wrap the root widget, here the MyHomePage4 with the InheritedCounter InheritedWidget
      home: InheritedCounter(
        child: MyHomePage4(),
      ),
    );
  }
}

class InheritedCounter extends InheritedWidget {
  // Every property inside the InheritedWidget must be a final
  // i.e. immutable, so we use a Map, immutable just means that the value
  // cannot be reassigned, once it is assigned, but in a Map, we don't reassign it
  // we just the value, this is similar to that of pointer, the pointer address cannot be
  // reassigned, its like a const pointer.

  final Map _counter = {'val': 0};
  final Widget child;

  InheritedCounter({this.child}) : super(child: child);

  increment() {
    _counter['val']++;
  }

  // Getter for the counter value

  get counter => _counter['val'];

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // what this does is, goes up the widget tree to see if it was inherited from
  // Inherited counter and returns an instance of this class, it's like a singleton
  // the state is global / shared state.
  static InheritedCounter of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedCounter);
}

class MyHomePage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // We also use a Stateful Builder here to get the setState function
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        int counter = InheritedCounter.of(context).counter;
        Function increment = InheritedCounter.of(context).increment;

        return DisplayCounter('Inherited Widget', counter, increment);
      },
    );
  }
}

///////////////////////////////// End of InheritedWidget

// 04. StreamBuilder + RxDart BehaviorSubject

Counter counterService = Counter();

class Counter {
  BehaviorSubject _counter = BehaviorSubject.seeded(0);

  Observable get stream$ => _counter.stream;
  int get current => _counter.value;

  increment() {
    _counter.add(current + 1);
  }
}

class MyHomePage5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: counterService.stream$,
          builder: (BuildContext context, AsyncSnapshot snap) {
            return Text('${snap.data}');
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterService.increment(),
      ),
    );

    // return DisplayCounter(
    //     'StreamBuilder + RxDart',
    //     StreamBuilder(
    //       stream: counterService.stream$,
    //       builder: (BuildContext context, AsyncSnapshot snap) {
    //         return snap.data;
    //       },
    //     ),
    //     counterService.increment);
  }
}

// 05. BLoC Architecture

enum CounterEvent { increment }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int currentState, CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}

// Root Widget
class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          BlocProvider<CounterBloc>(bloc: CounterBloc(), child: MyHomePage6()),
    );
  }
}

class MyHomePage6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context); // 4

    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC'),
      ),
      body: BlocBuilder(
          // 5
          bloc: _counterBloc,
          builder: (BuildContext context, int count) {
            return Text(
              '${count}',
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counterBloc.dispatch(CounterEvent.increment), // 6
      ),
    );
  }
}

/////////////////////////////////// End of BLoC
