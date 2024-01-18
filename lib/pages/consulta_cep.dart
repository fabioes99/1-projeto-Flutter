import 'package:_1_projeto/model/viacep.dart';
import 'package:_1_projeto/repositories/viacep_repository.dart';
import 'package:flutter/material.dart';

class ConsultaCep extends StatefulWidget {
  const ConsultaCep({super.key});

  @override
  State<ConsultaCep> createState() => _ConsultaCepState();
}

class _ConsultaCepState extends State<ConsultaCep> {
  var cepController = TextEditingController(text: "");
  var viacepModel = ViaCEPModel();
  var viaCEPRepository = ViaCepRepository();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
              "Consulta de CEP",
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              //maxLength: 8,
              onChanged: (String value) async {
                var cep = value.replaceAll(new RegExp(r'[^0-9]'), '');
                if (cep.length == 8) {
                  setState(() {
                    loading = true;
                  });
                  viacepModel = await viaCEPRepository.consultarCEP(cep);
                }
                setState(() {
                  loading = false;
                });
              },
            ),
             const SizedBox(
              height: 50,
            ),
            Text(
              viacepModel.logradouro ?? "",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
              style: TextStyle(fontSize: 22),
            ),
            if (loading) const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}