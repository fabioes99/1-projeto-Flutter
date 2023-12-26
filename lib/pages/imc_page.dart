import 'package:flutter/material.dart';
import 'package:_1_projeto/model/pessoa.dart';
import 'package:_1_projeto/repositories/imc_repository.dart';
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
  var imcRepository = ImcRepository();
  var _imc = <Pessoa>[];

  @override
  void initState() {
    super.initState();
    obterIMCPessoas();
  }

  void obterIMCPessoas() async{
    _imc = await imcRepository.listar();
    setState(() {});
    print(_imc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          dataController.text = '';
          pesoController.text = '';
          alturaController.text = '';
          showDialog(context: context, builder: (BuildContext bc) {
            return AlertDialog(
              title: const Text("Adicionar Dados"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Data", style: TextStyle(fontWeight: FontWeight.w700)),
                        TextField(
                        controller: dataController,
                        readOnly: true,
                        onTap: () async {
                          var data = await showDatePicker(context: context, 
                          firstDate: DateTime(1929,1,1),
                          lastDate: DateTime.now(),
                          initialDate: DateTime(2000,1,1)
                          );
                          if(data != null){
                             String dataFormatada = DateFormat('dd/MM/yyyy').format(data);
                              dataController.text = dataFormatada;
                          }
                        },
                      ),
                      ],
                    ),
                    _buildTextFieldWithLabel("Peso (kg)", pesoController),
                    _buildTextFieldWithLabel("Altura (cm)", alturaController),
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
                    await imcRepository.add(Pessoa(peso, altura, data));
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
          return Container(
           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: 
            Card(
              elevation: 16,
              shadowColor: Colors.purple.shade400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
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
          );
        }
    )


    );
  }

  Widget _buildTextFieldWithLabel(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        TextField(controller: controller),
      ],
    ),
  );
}

}