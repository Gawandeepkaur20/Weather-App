import 'package:flutter/material.dart';
import 'package:mausam/home.dart';
import 'package:mausam/loading.dart';
import 'package:mausam/location.dart';

void main() {
  runApp(MaterialApp(
      
      routes: {
        "/": (context) => Loading(),
        "/home": (context) => Home(),
        "/loading": (context) => Loading(),
      }));
}
