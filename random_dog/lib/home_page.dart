import 'package:flutter/material.dart';
import 'package:random_dog/result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageFromState();
}

class _HomePageFromState extends State<HomePage> {
  int _choise = 0;
  static const List<String> _options = [
    "random dog file",
    "random .jpg dog file",
    "random .mp4 dog file"
  ];

  void _setChoise(choise) {
    setState(() {
      _choise = choise;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Doggies!"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Show me a ' + _options[_choise],
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                    onPressed: () => _setChoise(0),
                    child: const Text('Random dog file'),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 25),
                    ),
                    onPressed: () => _setChoise(1),
                    child: const Text('Random .jpg dog file'),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    onPressed: () => _setChoise(2),
                    child: const Text('Random .mp4 dog file'),
                  ),
                ],
              ),
              FloatingActionButton.extended(
                label: Text('Go'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(mode: _choise),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
