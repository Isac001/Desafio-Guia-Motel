import 'package:desafio_guia_motel/controller/initializer_controllers.dart';
import 'package:desafio_guia_motel/list_motel_module/providers/motel_provider.dart';
import 'package:desafio_guia_motel/list_motel_module/screens/motel_list_screen.dart';
import 'package:desafio_guia_motel/list_motel_module/services/motel_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  InitializerControllers();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MotelProvider(MotelService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lista de Suítes',
        home: const MotelListScreen(),
      ),
    );
  }
}
