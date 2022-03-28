import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';
import 'dart:io' as io;
import "video_items.dart";

import 'package:video_player/video_player.dart';

Future<String> getDogFile(choise) async {
  try {
    final allDogs = await http.get(Uri.parse('https://random.dog/doggos'));
    if (allDogs.statusCode != 200) {
      return 'images/error_dog.jpg';
    }
    final allDogsDecoded = jsonDecode(allDogs.body);
    var num = Random();
    if (choise == 0) {
      return allDogsDecoded[num.nextInt(allDogsDecoded.length)];
    }
    List<String> mp4Dogs = [];
    for (int i = 0; i < allDogsDecoded.length; i++) {
      if (allDogsDecoded[i].contains('.mp4')) {
        mp4Dogs.add(allDogsDecoded[i]);
        allDogsDecoded.remove(allDogsDecoded[i]);
      }
    }
    if (choise == 1) {
      return allDogsDecoded[num.nextInt(allDogsDecoded.length)];
    }
    return mp4Dogs[num.nextInt(mp4Dogs.length)];
  } on Exception catch (_) {
    return 'images/error_dog.jpg';
  }
}

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.mode}) : super(key: key);

  final int mode;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Future<String> fileSource;
  late String fileExtention;

  @override
  void initState() {
    super.initState();
    fileSource = getDogFile(widget.mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Here is your doggie!!!"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<String>(
              future:
                  fileSource, // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                Widget children;
                if (snapshot.hasData) {
                  bool containsMP4 = snapshot.data!.toString().contains('.mp4');
                  if (snapshot.data!.toString() == 'images/error_dog.jpg') {
                    children = Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Flexible(
                            flex: 2,
                            child: Text(
                              'We could not find any other dogs',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Flexible(
                            flex: 2,
                            child: Text(
                              'Check your internet connection or vpn/proxy settings',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 25.0,
                            ),
                          ),
                          Flexible(
                            flex: 13,
                            child: Image.file(
                              io.File(snapshot.data!.toString()),
                              fit: BoxFit.cover,
                            ),
                          )
                        ]);
                  } else {
                    if (containsMP4) {
                      children = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            Flexible(
                                flex: 1,
                                child: VideoItems(
                                  videoPlayerController:
                                      VideoPlayerController.network(
                                          'https://random.dog/'
                                          '${snapshot.data!.toString()}'),
                                  looping: true,
                                  autoplay: true,
                                ))
                          ]);
                    } else {
                      children = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Image.network(
                                'https://random.dog/'
                                '${snapshot.data!.toString()}',
                                fit: BoxFit.cover,
                              ),
                            )
                          ]);
                    }
                  }
                } else if (snapshot.hasError) {
                  children = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 60,
                        ),
                      ]);
                } else {
                  children = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        Flexible(
                          flex: 3,
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            child: Text(
                              'We are searching for a dog!',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            ))
                      ]);
                }
                return children;
              }),
        ),
      ),
    );
  }
}
