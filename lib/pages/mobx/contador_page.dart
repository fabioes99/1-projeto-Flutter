import 'package:_1_projeto/services/contador_mobx_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../main.dart';

// ignore: must_be_immutable
class ContadorMobxPage extends StatelessWidget {
  ContadorMobxPage({super.key});
  var contadorMobxService = getIt<Contador>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: const Text(
              "Contador Mobx",
              style: TextStyle(fontSize: 26, color: Colors.blue , decoration: TextDecoration.none),
            ),
          ),
          Observer(
            builder: (context) => Text(
                  '${contadorMobxService.contador}',
                  style: const TextStyle(fontSize: 20, decoration: TextDecoration.none),
                )),
          TextButton(
              onPressed: () {
                contadorMobxService.incrementar();
              },
              child: const Text("Incrementar")),
        ],
      ),
    );
  }
}