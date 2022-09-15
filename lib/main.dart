import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:h5_project/color_picker.dart';
import 'package:h5_project/name_picker.dart';

import 'character.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android Assignment',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Home Page'),
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
  static Character character = Character();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(),
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Get ones name and color',
                  textScaleFactor: 1.5,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final Character? result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NamePicker(character: character)),
                      );

                      if (result != null){
                        setState(() {
                          character = result;
                        });
                      }

                    },
                    child: const Text('Get Ones Names')),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: character.color,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                        character.getName() ?? 'Here comes the name...',
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final Character? result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ColorPicker(character: character)),
                      );

                      if (result != null){
                        setState(() {
                          character = result;
                        });

                        print(character);
                      }
                    },
                    child: const Text('Get Ones Color')),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }

  String getName(Character item) {
    if(item.name == null || item.type == null){
      return 'Here comes the name';
    }

    String formattedEnum = character.type.toString().split(".")[1];
    formattedEnum = '${formattedEnum[0].toUpperCase()}${formattedEnum.substring(1)}';

    return '$formattedEnum: ${character.name}';
  }
}
