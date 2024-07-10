import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_with_node_1/app.dart';
import 'package:flutter_with_node_1/dependency_injection.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await init(); //calling DependencyInjection init method
  runApp(const App());
}
