import 'package:flutter/material.dart';
import 'package:netword_logger/api_logs_screen.dart';
import 'package:netword_logger/movable_button.dart';
import 'package:provider/provider.dart';

import 'feature/api_response/provider/api_response.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiResponseProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey:
            scaffoldMessengerKey, // Assign the global key here

        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: Stack(
        children: [
          MovableButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ApiListScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
