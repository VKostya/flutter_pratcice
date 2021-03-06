import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_dog/result_page.dart';

import 'dark_theme/dark_theme_provider.dart';

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
          title: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.brightness_6),
                color: Colors.white,
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .swapTheme();
                },
              ),
              const Text(
                "Doggies!",
                textAlign: TextAlign.center,
              ),
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Show me a ' + _options[_choise],
              style: const TextStyle(fontSize: 25),
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
                  child: const Text('Random .jpg or .gif dog file'),
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
                const SizedBox(
                  height: 25.0,
                ),
              ],
            ),
            FloatingActionButton.extended(
              label: const Text('Go'),
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
    );
  }
}
