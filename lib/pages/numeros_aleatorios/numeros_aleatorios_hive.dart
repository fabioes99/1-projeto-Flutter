import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHive extends StatefulWidget {
  const NumerosAleatoriosHive({super.key});

  @override
  State<NumerosAleatoriosHive> createState() => _NumerosAleatoriosHiveState();
}

class _NumerosAleatoriosHiveState extends State<NumerosAleatoriosHive> {
  int? numeroGerado = 0;
  int? qtdCliques = 0;
  late Box boxNumerosAleatorios;
  
  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async{
    if (Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');      
    }else{
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');      
    }

    setState(() {
      numeroGerado = boxNumerosAleatorios.get('numero_aleatorio') ?? 0;
      qtdCliques = boxNumerosAleatorios.get('qtd_cliques') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Numero aleatorios com Hive"),
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
            boxNumerosAleatorios.put('numero_aleatorio', numeroGerado!);
            boxNumerosAleatorios.put('qtd_cliques', qtdCliques!);
           },),
      ),
    );
  }
}