import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'dart:math';
import 'dart:io' as io;
import "video_items.dart";
import 'package:video_player/video_player.dart';

/*:Text(
                              'I do not know how to work with a videos yet',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            )*/

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
    return 'assets/error_dog.jpg';
  } on Exception catch (_) {
    return 'assets/error_dog.jpg';
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
  bool loading = false;
  bool mode_mp4 = false;

  @override
  void initState() {
    super.initState();
    fileSource = getDogFile(widget.mode);
    if (widget.mode == 2) {
      mode_mp4 = true;
    }
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
              future: fileSource,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                Widget children;
                if (snapshot.hasData) {
                  if (snapshot.data!.toString() == 'assets/error_dog.jpg') {
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
                              )),
                          Flexible(
                            flex: 2,
                            child: Text(
                              '${mode_mp4 ? 'I do not know how to work with a videos yet' : "Check your internet connection"}',
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
                    bool containsMP4 =
                        snapshot.data!.toString().contains('.mp4');
                    String fileName =
                        'https://random.dog/' '${snapshot.data!.toString()}';
                    children = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        containsMP4
                            ? Flexible(
                                flex: 14,
                                child: VideoItems(
                                  videoPlayerController:
                                      VideoPlayerController.network(fileName),
                                  looping: true,
                                  autoplay: true,
                                ))
                            : Flexible(
                                flex: 14,
                                child: Image.network(
                                  fileName,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                              ),
                        const Flexible(flex: 1, child: SizedBox(height: 25.0)),
                        Flexible(
                            flex: 1,
                            child: FloatingActionButton.extended(
                                onPressed: () {
                                  Share.share(
                                      'Check this amusing dog ' + fileName);
                                },
                                label: const Text("Share this dog!")))
                      ],
                    );
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
