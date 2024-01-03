import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:_1_projeto/repositories/config_repository.dart';
import 'package:_1_projeto/model/config.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();
  late Box configuracoes;

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
    
    configuracoesRepository = await ConfiguracoesRepository.carregar();

    configuracoesModel = configuracoesRepository.obterDados();

    setState(() {
      nomeUsuarioController.text = configuracoesModel.nomeUsuario;
      alturaController.text = configuracoesModel.altura.toString();
      receberNotificacoes = configuracoesModel.receberNotificacoes;
      temaEscuro = configuracoesModel.temaEscuro;
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
              configuracoesModel.altura = double.parse(alturaController.text);
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

              configuracoesModel = ConfiguracoesModel(nomeUsuarioController.text, configuracoesModel.altura, receberNotificacoes, temaEscuro);
              configuracoesRepository.salvar(configuracoesModel);
              Navigator.pop(context);
            }, child: Text("Salvar"))
          ],
          ),
      ),);
  }
}