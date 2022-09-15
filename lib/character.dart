import 'dart:ui';
import "utility.dart";

enum Selections { mother, father, cat, dog }

class Character {
  String? name;
  Selections? type;
  Color? color;

  Character({this.name, this.type, this.color});

  String? getName() {
    if(name == null || type == null){
      return null;
    }

    return '${getTypeAsString()}: $name';
  }

  String? getTypeAsString(){
    if(type == null){
      return null;
    }

    return type.toString().split(".")[1].capitalize();
  }

  @override
  String toString() {
    return '{name: $name, type: ${type.toString()}, color: ${color.toString()} }';
  }
}