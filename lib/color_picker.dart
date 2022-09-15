import 'package:flutter/material.dart';
import 'character.dart';

const List<String> colorList = <String>[
  '00',
  '10',
  '20',
  '30',
  '40',
  '50',
  '60',
  '70',
  '80',
  '90',
  'A0',
  'B0',
  'C0',
  'D0',
  'E0',
  'F0',
  'FF'
];

class ColorPicker extends StatefulWidget {
  const ColorPicker({super.key, required this.character});
  final Character character;

  @override
  State<ColorPicker> createState() => _ColorPicker();
}

class _ColorPicker extends State<ColorPicker> {
  late String redColor;
  late String greenColor;
  late String blueColor;

  @override
  void initState() {
    super.initState();

    redColor   = getStringFromHex(widget.character.color?.red);
    greenColor = getStringFromHex(widget.character.color?.green);
    blueColor  = getStringFromHex(widget.character.color?.blue);
  }

  @override
  Widget build(BuildContext context) {
    Color color = Color.fromARGB(0xFF, int.parse('0x$redColor'), int.parse('0x$greenColor'), int.parse('0x$blueColor'));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color selector page'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 2, // 20%
            child: Container(),
          ),
          Expanded(
            flex: 6, // 20%
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.character.type != null ? '${widget.character.getTypeAsString()}\'s Color' : 'Choose the Color',
                  textScaleFactor: 1.5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: color,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Red'),
                    dropDown(redColor, (value) => {
                      setState(() {
                        redColor = value!;
                      }),
                    }),
                    const Text('Green'),
                    dropDown(greenColor, (value) => {
                      setState(() {
                        greenColor = value!;
                      }),
                    }),
                    const Text('Blue'),
                    dropDown(blueColor, (value) => {
                      setState(() {
                        blueColor = value!;
                      }),
                    }),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.character.color = color;
                    print(color.red.toRadixString(16));

                    Navigator.pop(
                      context,
                      widget.character,
                    );
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2, // 20%
            child: Container(),
          ),
        ],
      ),
    );
  }

  String getStringFromHex(int? color){
    return color?.toRadixString(16).padLeft(2, '0').toUpperCase() ?? colorList.first;
  }

  DropdownButton dropDown(String color, Function change){
    return DropdownButton<String>(
      value: color,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        change(value);
      },
      items:
      colorList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
