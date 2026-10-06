import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();

  String result = '';

  void calculate(String operation) {
    String input1 = num1Controller.text;
    String input2 = num2Controller.text;

    if (input1.isEmpty || input2.isEmpty) {
      setState(() {
        result = 'Error: please enter both numbers';
      });
      return;
    }

    double? num1 = double.tryParse(input1);
    double? num2 = double.tryParse(input2);

    if (num1 == null || num2 == null) {
      setState(() {
        result = 'Error: inputs must be valid numbers';
      });
      return;
    }

    double answer = 0;

    if (operation == '+') {
      answer = num1 + num2;
    } else if (operation == '-') {
      answer = num1 - num2;
    } else if (operation == '*') {
      answer = num1 * num2;
    } else if (operation == '/') {
      if (num2 == 0) {
        setState(() {
          result = 'Error: cannot divide by zero';
        });
        return;
      }
      answer = num1 / num2;
    }

    setState(() {
      result = answer.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Four Function Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'First Number'),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Second Number'),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text('+'),
                ),

                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text('-'),
                ),

                ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: const Text('*'),
                ),

                ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: const Text('/'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
