import 'package:_1_projeto/pages/forum/sala_model.dart';
import 'package:_1_projeto/pages/forum/sala_widget.dart';
import 'package:_1_projeto/pages/forum/service_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SalasPage extends StatefulWidget {
  const SalasPage({super.key});

  @override
  State<SalasPage> createState() => _SalasPageState();
}

class _SalasPageState extends State<SalasPage> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
  appBar: AppBar(title: const Text('Salas Disponiveis'),),
  body: SafeArea(
    child: StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().getSalasStream(),
      builder: (context, snapshot) {
        return !snapshot.hasData
          ? const SizedBox( height: 80, child: CircularProgressIndicator())
          : Column(
            children: [
              Expanded(
                child: ListView(
                  children: snapshot.data!.docs.map((e) {
                    var salaModel = SalaModel.fromJson(
                      (e.data() as Map<String, dynamic>));
                    return SalaWidget( salaModel: salaModel, );
                  }).toList(),
                ),
              ),
            ],
          );
      },
    ),
  ),
);

  }
}