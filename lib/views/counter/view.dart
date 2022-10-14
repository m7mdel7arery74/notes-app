import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int counter = 0;

  @override
  void initState() {
    SharedPreferences.getInstance().then((sp) {
      counter = sp.getInt('counter') ?? 0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter is $counter'),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                counter = 0;
                sp.setInt('counter', counter);
                setState(() {});
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          counter++;
          sp.setInt('counter', counter);
          setState(() {});
        },
      ),
    );
  }
}