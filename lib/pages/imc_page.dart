import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  var dataController = TextEditingController();
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();

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
                    _buildTextFieldWithLabel("Data", dataController),
                    _buildTextFieldWithLabel("Peso (kg)", pesoController),
                    _buildTextFieldWithLabel("Altura (cm)", alturaController),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () { Navigator.pop(context); }, child: const Text('Cancelar')),
                TextButton(onPressed: () { 
                  Navigator.pop(context); 
                }, child: const Text('Salvar')),
              ],
            );
          });
        }),
      body: Column(
        children: [
          Container(
           margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: 
            Card(
              elevation: 16,
              shadowColor: Colors.purple.shade400,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(child: Text("25/03/2023", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Image.network( !.url, width: 100,),
                            Text( "Peso: 82,9 kg"),
                            Text( "Altura: 192 cm"),
                          ],
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text( "IMC: 26"),
                            Text( "Categoria: Peso Ideal"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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