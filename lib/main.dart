import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/theme.dart';
import 'pages/splash_page.dart';
import 'repository/poke_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PokeRepository(),
      child: _buildMaterial(),
    );
  }

  Widget _buildMaterial() {
    return MaterialApp(
      theme: appTheme(),
      title: 'PokeAPI',
      home: const SplashPage(),
    );
  }
}
