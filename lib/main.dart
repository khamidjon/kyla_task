import 'package:flutter/material.dart';
import 'package:khamidjon_kyla/slidable_button.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
                child: BottomNavigationWidget(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: VerticalSlidableButton(
                buttonColor: _isInitialState ? Colors.white : Colors.blueAccent,
                icon: Icon(
                  Icons.close,
                  color: _isInitialState ? Colors.blueAccent : Colors.white,
                ),
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

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
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
        const SizedBox(width: 32),
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
