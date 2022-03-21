import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageFromState();
}

class _HomePageFromState extends State<HomePage> {
  final _controller = TextEditingController();
  bool texterror = false;

  @override
  void initState() {
    _controller.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Doggies!"),
      ),
    );
  }
}
