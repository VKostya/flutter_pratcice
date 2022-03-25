import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.mode}) : super(key: key);

  final int mode;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hi"),
      ),
    );
  }
}
