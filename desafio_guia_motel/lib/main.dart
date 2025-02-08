import 'package:desafio_guia_motel/controllers/initializer_controllers.dart';
import 'package:desafio_guia_motel/list_motel_module/screens/motel_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  InitializerControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de Suítes',

      home: const MotelListScreen(), 
    );
  }
}
