import 'package:_1_projeto/model/cep_back4app.dart';
//import 'package:_1_projeto/model/viacep.dart';
import 'package:_1_projeto/repositories/viacep_repository.dart';
import 'package:_1_projeto/repositories/back4app/cep_back4app_repository.dart';
import 'package:_1_projeto/shared/widgets/text_label.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsultaCep extends StatefulWidget {
  const ConsultaCep({super.key});

  @override
  State<ConsultaCep> createState() => _ConsultaCepState();
}

class _ConsultaCepState extends State<ConsultaCep> {
  final ScrollController _scrollController = ScrollController();
  var cepController = TextEditingController(text: "");
  CEP viacepModel = CEP();
  var viaCEPRepository = ViaCepRepository();
  var cepBack4appRepository =  CEPBack4appRepository() ;
  CEPBack4appModel listaCep = CEPBack4appModel([]);
  String cepNotFound = '';
  bool loading = false;
  var carregando = false;
  int skip = 0;

  @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.9;
      if (_scrollController.position.pixels > posicaoParaPaginar) {
        carregarDados();
      }
    });
    super.initState();
    carregarDados();
  }


  carregarDados() async {
    if (carregando) return;
    if ( listaCep.ceps.isEmpty ) {
      listaCep = await cepBack4appRepository.obterCEPS(skip);
    } else {
      setState(() {
        carregando = true;
      });
      skip = skip + listaCep.ceps.length;
      var tempList = await cepBack4appRepository.obterCEPS(skip);
      listaCep.ceps.addAll(tempList.ceps);
      carregando = false;
    }
    setState(() {});
  }


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
            TextFormField(
              controller: cepController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CepInputFormatter(),
              ],
              //maxLength: 8,
              onChanged: (String value) async {
                var cepTexto = value.replaceAll( RegExp(r'[^0-9]'), '');
                if (cepTexto.length == 8) {
                  viacepModel = await viaCEPRepository.consultarCEP(cepTexto);
                  if(!listaCep.verificaCEP(cepTexto)){
                    cepBack4appRepository.post(viacepModel);
                    carregarDados();
                  }
                  setState(() {
                    cepNotFound = '';
                    loading = true;
                  });
                  
                }else{
                  cepNotFound = 'Não foi encontrado o CEP';
                  setState(() {
                    viacepModel.localidade = '' ;
                    viacepModel.logradouro = '';
                    viacepModel.uf = '';
                  });
                }
                setState(() {
                  loading = false;
                });
              },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                constraints: const BoxConstraints(maxHeight: 90),
                child: cepNotFound.isNotEmpty ? 
                Text(cepNotFound, style: const TextStyle(fontSize: 22)) : 
                loading ? 
                const Center(child: SizedBox( height: 50, width: 50, child: CircularProgressIndicator())) : 
              Text(
                '${viacepModel.logradouro ?? ""}\n${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}',
                style: const TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              ),
                const SizedBox(
                height: 20,
              ),
              const Text(
                "Endereços já pesquisados:",
                style: TextStyle(fontSize: 22),
              ),
              Expanded(child: ListView.builder(
                controller: _scrollController,
                itemCount: listaCep.ceps.length,
                itemBuilder: (_, int index) {
                  var cep = listaCep.ceps[index];
                  var cepBack4appController = TextEditingController(text: "");
                  var logradouroController = TextEditingController(text: "");
                  var cidadeController= TextEditingController(text: "");
                  var siglaController = TextEditingController(text: "");
                  var complementoController = TextEditingController(text: "");
                  var bairroController= TextEditingController(text: "");
                  cepBack4appController.text = cep.cep ?? '';
                  logradouroController.text = cep.logradouro ?? '';
                  siglaController.text = cep.uf ?? '';
                  complementoController.text = cep.complemento ?? '';
                  bairroController.text = cep.bairro ?? '';
                  cidadeController.text = cep.localidade ?? '';
                  
                  return Dismissible(
                    onDismissed: (DismissDirection dissmisDirection) async{
                      await cepBack4appRepository.delete(cep.objectId!);
                      carregarDados();
                    },
                    key: Key(cep.objectId!),
                    child: 
                    InkWell(
                      onTap: () {
                      showDialog(context: context, builder: (BuildContext bc) {
                        return AlertDialog(
                        title: const Text("Editar CEP") ,
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              const TextLabel(texto: "CEP"),
                              TextFormField( inputFormatters: [FilteringTextInputFormatter.digitsOnly, CepInputFormatter(),], controller: cepBack4appController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "01001001"),),
                              const TextLabel(texto: "Logradouro"),
                              TextField( controller: logradouroController, decoration: const InputDecoration(hintText: "Rua hello world"),),
                               const TextLabel(texto: "Cidade"),
                              TextField( controller: cidadeController, decoration: const InputDecoration(hintText: "São Paulo"),),
                               const TextLabel(texto: "Sigla"),
                              TextField( controller: siglaController, decoration: const InputDecoration(hintText: "SP"),),
                               const TextLabel(texto: "Bairro"),
                              TextField( controller: bairroController, decoration: const InputDecoration(hintText: "Bairro"),),
                               const TextLabel(texto: "Complemento"),
                              TextField( controller: complementoController, decoration: const InputDecoration(hintText: "Casa, apartamento"),),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: () { Navigator.pop(context); }, child: const Text('Cancelar')),
                          TextButton(onPressed: () async{                           
                            await cepBack4appRepository.update(
                              CEP( 
                                objectId: cep.objectId, 
                                cep: cepBack4appController.text,
                                logradouro: logradouroController.text, 
                                complemento: complementoController.text, 
                                bairro: bairroController.text, 
                                localidade: cidadeController.text, 
                                uf: siglaController.text
                              ));
                          Navigator.pop(context); 
                          carregarDados();
                        }, child: const Text('Salvar')),
                        ],
                        );
                      } );
                        
                      },
                      child: Container(
                        margin: const EdgeInsets.all(13.0),
                        child: Card(
                          elevation: 16,
                          shadowColor: Colors.purple.shade400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Center(child: Text( UtilBrasilFields.obterCep(cep.cep ?? '') , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text( "${cep.logradouro} - ${cep.localidade} - ${cep.uf}")),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Expanded(child: Text( "${cep.bairro} - ${cep.complemento} " )),
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
              )),
              !carregando
              ? ElevatedButton(
                  onPressed: () {
                    carregarDados();
                  },
                  child: const Text("Carregar mais CEP"))
              : const CircularProgressIndicator() 
            ],
          ),
        ),
      ),
    );
  }
}