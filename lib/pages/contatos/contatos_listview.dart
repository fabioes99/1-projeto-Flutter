import 'dart:io';

import 'package:flutter/material.dart';
import 'package:_1_projeto/model/contatos.dart';

class ContatoCard extends StatelessWidget {
  final ContatoModel contato;
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;

  const ContatoCard({
    required this.contato,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(contato.objectId!),
      onDismissed: (_) async {
        await onDelete();
      },
      child: InkWell(
        onTap: onEdit,
        child: Container(
          margin: const EdgeInsets.all(13.0),
          child: Card(
            elevation: 16,
            shadowColor: Colors.purple.shade400,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: FileImage(File(contato.pathPhoto ?? "")),
                      ),
                      Text(
                        " ${contato.nome} \n ${contato.telefone} \n ${contato.email} \n ${contato.cpf} ",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContatosList extends StatelessWidget {
  final List<ContatoModel> contatos;
  final Future<void> Function(ContatoModel) onDelete;
  final void Function(ContatoModel) onEdit;

  const ContatosList({
    required this.contatos,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (_, index) {
        final contato = contatos[index];
        return ContatoCard(
          contato: contato,
          onDelete: () => onDelete(contato),
          onEdit: () => onEdit(contato),
        );
      },
    );
  }
}
