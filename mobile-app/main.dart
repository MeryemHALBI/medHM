import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'services/analysis_provider.dart';

void main() {
  runApp(const MedetApp());
}

class MedetApp extends StatelessWidget {
  const MedetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnalysisProvider(),
      child: MaterialApp(
        title: 'medet — Détection de polypes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.teal,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
