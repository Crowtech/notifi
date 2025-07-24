import 'dart:async';

import 'package:bdaya_shared_value/bdaya_shared_value.dart';
import 'package:flutter/material.dart';

// This global SharedValue can be shared across the entire app
final SharedValue<int> counter = SharedValue(
  value: 0, // initial value
  key: "counter", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<Duration> randomValue = SharedValue(value: Duration.zero);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // load previous value from shared prefs
  counter.load();

  DateTime startedAt = DateTime.now();
  Timer.periodic(Duration(milliseconds: 50), (timer) {
    randomValue.$ = DateTime.now().difference(startedAt);
  });

  runApp(
    // don't forget this!
    SharedValue.wrapApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("MyApp.build()");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Shared value demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              CounterText(),
              Padding(
                padding: const EdgeInsets.all(32),
                child: RandomText(),
              ),
            ],
          ),
        ),
        floatingActionButton: CounterButton(),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    // The .of(context) bit makes this widget rebuild automatically
    int counterValue = counter.of(context);

    print("CounterText.build() - $counterValue");

    return Text(
      '$counterValue',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class CounterButton extends StatelessWidget {
  const CounterButton({super.key});

  @override
  Widget build(BuildContext context) {
    print("Button.build()");

    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }

  void _incrementCounter() {
    // update counter value and rebuild widgets
    counter.$ += 1;
  }
}

class RandomText extends StatelessWidget {
  const RandomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Your time here: ${randomValue.of(context)}");
  }
}
