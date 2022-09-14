import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoplistappsm/app/my_app.dart';

import 'package:shoplistappsm/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
