import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late SharedPreferences storage;

  final CHAVE_NOME_USUARIO = 'nome_usuario';
  final CHAVE_ALTURA_USUARIO = 'altura';
  final CHAVE_RECEBER_NOTIFICACAO = 'receber_notificacao';
  final CHAVE_TEMA_ESCURO = 'tema_escuro';

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? nomeUsuario;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async{
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuarioController.text = storage.getString(CHAVE_NOME_USUARIO) ?? "";
      alturaController.text = (storage.getDouble(CHAVE_ALTURA_USUARIO) ?? 0).toString();
      receberNotificacoes = storage.getBool(CHAVE_RECEBER_NOTIFICACAO) ?? false;
      temaEscuro = storage.getBool(CHAVE_TEMA_ESCURO) ?? false;
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Configurações"), ), 
        body: ListView(children: [
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(hintText: "Nome usuário"),
                controller: nomeUsuarioController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Altura"),
                controller: alturaController,
              ),
            ),
            SwitchListTile(
              title: const Text("Receber notificações"),
              value: receberNotificacoes, 
              onChanged: (bool value) {
              setState(() {
                receberNotificacoes = value;
              });
            }),
            SwitchListTile(
              title: Text("Tema Escuro"),
              value: temaEscuro, 
              onChanged: (bool value) {
              setState(() {
                temaEscuro = value;
              });
            }),
            TextButton(onPressed: () async{
              FocusManager.instance.primaryFocus?.unfocus();
            try {
              await storage.setDouble(CHAVE_ALTURA_USUARIO,double.parse(alturaController.text));
            } catch (e) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("Meu App"),
                      content:
                          Text("Favor informar uma altura válida!"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"))
                      ],
                    );
                  });
              return;
            }
              await storage.setString(CHAVE_NOME_USUARIO, nomeUsuarioController.text);
              await storage.setBool(CHAVE_RECEBER_NOTIFICACAO, receberNotificacoes);
              await storage.setBool(CHAVE_TEMA_ESCURO, temaEscuro);
              Navigator.pop(context);
            }, child: Text("Salvar"))
          ],
          ),
      ),);
  }
}