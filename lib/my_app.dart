import 'package:_1_projeto/pages/splash_screen/splash_screen.dart';
import 'package:_1_projeto/repositories/tarefas/tarefa_provider_repository.dart';
import 'package:_1_projeto/services/contador.dart';
import 'package:_1_projeto/services/dark_mode.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeService>(create: (_) => DarkModeService()),
        ChangeNotifierProvider<ContadorService>(create: (_) => ContadorService()),
        ChangeNotifierProvider<TarefaProviderRepository>(create: (_) => TarefaProviderRepository()),
      ],
      child: Consumer<DarkModeService>(
        builder: (_, darkModeService, widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: darkModeService.darkMode ? ThemeData.light() : ThemeData.dark(),
            home: const SplashScreen(),
          );
        }
      ),
    );
  }
}