import 'package:_1_projeto/repositories/sqlite/imc_sqlite_repository.dart';
import 'package:_1_projeto/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:_1_projeto/model/pessoa.dart';
import 'package:intl/intl.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  var dataController = TextEditingController();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var imcRepository = ImcSqliteRepository();
  var _imc = <Pessoa>[];

  @override
  void initState() {
    super.initState();
    obterIMCPessoas();
  }

  void obterIMCPessoas() async{
    _imc = await imcRepository.obterDados();
    setState(() {});
    debugPrint(_imc.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          dataController.clear();
          pesoController.clear();
          alturaController.clear();
          showDialog(context: context, builder: (BuildContext bc) {
            return AlertDialog(
              title: const Text("Adicionar Dados"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                        decoration: const InputDecoration(hintText: "Data"),
                        controller: dataController,
                        readOnly: true,
                        onTap: () async {
                          var data = await showDatePicker(context: context, 
                          firstDate: DateTime(2018,1,1),
                          lastDate: DateTime.now(),
                          initialDate: DateTime(2024,1,1)
                          );
                          if(data != null){
                             String dataFormatada = DateFormat('dd/MM/yyyy').format(data);
                              dataController.text = dataFormatada;
                          }
                        },
                      ),
                      ],
                    ),
                    TextField(controller: pesoController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Peso kg"),),
                    TextField(controller: alturaController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Altura cm"),),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () { Navigator.pop(context); }, child: const Text('Cancelar')),
                TextButton(onPressed: () async{ 
                  String pesoTexto = pesoController.text;
                  String alturaTexto = alturaController.text;
                  double? peso = double.tryParse(pesoTexto);
                  double? altura = double.tryParse(alturaTexto);
                  String data = dataController.text;
                  if (peso != null && altura != null) {
                    await imcRepository.add(Pessoa( 0, peso, altura, data));
                  } else {
                      print("Erro: Peso ou altura não puderam ser convertidos para double.");
                  }
                  Navigator.pop(context); 
                  obterIMCPessoas();
                }, child: const Text('Salvar')),
              ],
            );
          });
        }),
      body: ListView.builder(
          itemCount: _imc.length,
          itemBuilder: (BuildContext context, int index) {
          var dados = _imc[index];
          var dataEditController = TextEditingController();
          var pesoEditController = TextEditingController();
          var alturaEditController = TextEditingController();
          dataEditController.text = dados.getData();
          pesoEditController.text = dados.getPeso().toString();
          alturaEditController.text = dados.getAltura().toString();
          return Dismissible(
            onDismissed: (DismissDirection dissmisDirection) async{
              await imcRepository.delete(dados.getId());
              obterIMCPessoas();
            },
            key: Key(dados.getId().toString()),
            child: 
            InkWell(
               onTap: () {
               showDialog(context: context, builder: (BuildContext bc) {
                return AlertDialog(
                title: Text("Editar Dados") ,
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TextLabel(texto: "Data"),
                      TextField(
                          decoration: const InputDecoration(hintText: "Data"),
                          controller: dataEditController,
                          readOnly: true,
                          onTap: () async {
                            var data = await showDatePicker(context: context, 
                            firstDate: DateTime(2018,1,1),
                            lastDate: DateTime.now(),
                            initialDate: DateTime(2024,1,1)
                            );
                            if(data != null){
                               String dataFormatada = DateFormat('dd/MM/yyyy').format(data);
                                dataEditController.text = dataFormatada;
                            }
                          },
                        ),
                      const TextLabel(texto: "Peso"),
                      TextField( controller: pesoEditController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Peso kg"),),
                      const TextLabel(texto: "Altura"),
                      TextField( controller: alturaEditController,keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Altura cm"),),
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: () { Navigator.pop(context); }, child: const Text('Cancelar')),
                  TextButton(onPressed: () async{ 
                  String pesoTexto = pesoEditController.text;
                  String alturaTexto = alturaEditController.text;
                  double? peso = double.tryParse(pesoTexto);
                  double? altura = double.tryParse(alturaTexto);
                  String data = dataController.text;
                  if (peso != null && altura != null) {
                    await imcRepository.update(Pessoa( dados.getId(), peso, altura, data));
                  } else {
                      print("Erro: Peso ou altura não puderam ser convertidos para double.");
                  }
                  Navigator.pop(context); 
                  obterIMCPessoas();
                }, child: const Text('Salvar')),
                ],
                );
              } );
                
              },
              child: Container(
                margin: EdgeInsets.all(13.0),
                child: Card(
                  elevation: 16,
                  shadowColor: Colors.purple.shade400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Center(child: Text(dados.getData().toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text( "Peso ${dados.getPeso().toString()} kg" ),
                                Text( "Altura ${dados.getAltura().toString()} cm"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text( "IMC: ${dados.getImc().toString()}"  ),
                                Text( dados.getClassificacao()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    )
    );
  }

}