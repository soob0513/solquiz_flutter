import 'package:flutter/material.dart';

class Provider with ChangeNotifier{
  DateTime initialDay = DateTime.now();
  DateTime get _initialDay => initialDay;

}