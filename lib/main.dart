import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isInitialState = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedCrossFade(
        duration: const Duration(seconds: 1),
        firstChild: InitialStateWidget(
          changeState: _changeState,
        ),
        secondChild: FinalStateWidget(
          changeState: _changeState,
        ),
        crossFadeState:
            _isInitialState ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }

  void _changeState() {
    setState(() {
      _isInitialState = !_isInitialState;
    });
  }
}

class InitialStateWidget extends StatelessWidget {
  const InitialStateWidget({
    required this.changeState,
    super.key,
  });

  final VoidCallback changeState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.blueAccent,
      child: Center(
        child: FloatingActionButton(
          onPressed: changeState,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class FinalStateWidget extends StatelessWidget {
  const FinalStateWidget({
    required this.changeState,
    super.key,
  });

  final VoidCallback changeState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home),
                color: Colors.deepPurpleAccent,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: Colors.deepPurpleAccent,
              ),
              FloatingActionButton(
                onPressed: changeState,
                child: const Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.flash_on),
                color: Colors.deepPurpleAccent,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person),
                color: Colors.deepPurpleAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
