import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatorios extends StatefulWidget {
  const NumerosAleatorios({super.key});

  @override
  State<NumerosAleatorios> createState() => _NumerosAleatoriosState();
}

class _NumerosAleatoriosState extends State<NumerosAleatorios> {
  int? numeroGerado = 0;
  int? qtdCliques = 0;
  late SharedPreferences storage;
  
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async{
    storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt('numero_aleatorio');
      qtdCliques = storage.getInt('qtd_cliques');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Numero aleatorios"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(numeroGerado.toString(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),),
              Text(qtdCliques.toString(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),)
              ])),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async{ 
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              qtdCliques = (qtdCliques ?? 0) + 1;
            });
            storage.setInt('numero_aleatorio', numeroGerado!);
            storage.setInt('qtd_cliques', qtdCliques!);
           },),
      ),
    );
  }
}