import 'package:flutter/material.dart';

class DadosCadastrais extends StatefulWidget {
 const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  var nomeController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold( 
        appBar: AppBar(title: const Text("Meus Dados"),),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("dados cadastrais", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),),
              TextField(
                controller: nomeController,
              ),
            ],
          ),
        ),
      ),      
    );
  }
}
