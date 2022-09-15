import 'package:flutter/material.dart';
import "utility.dart";

import 'character.dart';

class NamePicker extends StatefulWidget {
  const NamePicker({super.key, required this.character});

  final Character character;

  @override
  State<NamePicker> createState() => _NamePicker();
}

class _NamePicker extends State<NamePicker> {
  late Selections _selected;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.character.name ?? '');
    _selected = widget.character.type ?? Selections.mother;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character selector page'),
      ),
      body: SingleChildScrollView(child: Row(
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
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  "Write the name of your...",
                  textScaleFactor: 1.5,
                ),
                for ( var selection in Selections.values )
                ListTile(
                  title: Text(selection.toString().split(".")[1].capitalize()),
                  leading: Radio<Selections>(
                    value: selection,
                    groupValue: _selected,
                    onChanged: (Selections? value) {
                      setState(() {
                        _selected = value!;
                      });
                    },
                  ),
                ),
                TextField(
                  controller: _nameController,
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.character.name = _nameController.text;
                    widget.character.type = _selected;

                    Navigator.pop(
                      context,
                      widget.character,
                    );
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
      )
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
