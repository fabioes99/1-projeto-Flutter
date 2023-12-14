import 'dart:math';

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:  Colors.red
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  var numeroAleatorio = 0;

  int _gerarNumeroAleatorio(){
    Random numeroAleatorio = Random();
    return numeroAleatorio.nextInt(1000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Meu app"),
      ),
      body: Center(child: Text(numeroAleatorio.toString())),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState( () {
            numeroAleatorio = _gerarNumeroAleatorio();
          } );          
        },
      ),
    );
  }
}