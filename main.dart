import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'pages/my_app_.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('shopping_box');

  runApp(const MyApp());
}
