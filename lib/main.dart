import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hakkyo/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  Flame.device.fullScreen();
  runApp(const MyApp());
}

