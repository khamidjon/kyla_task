import 'package:flutter/material.dart';
import 'package:khamidjon_kyla/slidable_button.dart';
import 'package:khamidjon_kyla/slidable_button_position.dart';

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
      body: Container(
        color: _isInitialState ? Colors.blueAccent : Colors.white,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom + 16,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Visibility(
              visible: !_isInitialState,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: FinalStateWidget(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: VerticalSlidableButton(
                height: MediaQuery.of(context).size.height / 3,
                width: 48,
                buttonHeight: 48.0,
                buttonColor: _isInitialState ? Colors.white : Colors.blueAccent,
                label: Icon(
                  Icons.close,
                  color: _isInitialState ? Colors.blueAccent : Colors.white,
                ),
                completeSlideAt: _isInitialState ? 0.0 : 1.0,
                onChanged: (position) {
                  setState(() {
                    _isInitialState = position == SlidableButtonPosition.start;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinalStateWidget extends StatelessWidget {
  const FinalStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 24),
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
    );
  }
}
