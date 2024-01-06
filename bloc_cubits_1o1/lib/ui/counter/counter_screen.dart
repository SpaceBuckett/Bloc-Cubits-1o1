import 'package:bloc_cubits_1o1/core/cubits/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final counterCubit = CounterCubit(initValue: 88);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            CounterText(counterCubit: counterCubit),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 35.0, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                counterCubit.decrement();
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: () {
                counterCubit.increment();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({
    super.key,
    required this.counterCubit,
  });

  final CounterCubit counterCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(
      bloc: counterCubit,
      builder: (context, counter) => Text(
        '$counter',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: counterCubit.isMatchedInitialValue()
                  ? Colors.green
                  : Colors.redAccent,
            ),
      ),
    );
  }
}