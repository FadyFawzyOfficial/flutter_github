import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/repositories.dart';
import 'uis/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Repositories(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub',
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
