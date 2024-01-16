import 'package:_1_projeto/repositories/dados_cadastrais_repository.dart';
import 'package:_1_projeto/repositories/linguagens_repository.dart';
import 'package:_1_projeto/repositories/nivel_repository.dart';
import 'package:_1_projeto/shared/widgets/text_label.dart';
import 'package:_1_projeto/model/dados_cadastrais_model.dart';
import 'package:flutter/material.dart';

class DadosCadastrais extends StatefulWidget {
 const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();

  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");

  DateTime? dataNascimento ;
  var nivelRepository = NivelRepository();
  var niveis = [];
  String nivelSelecionado = '';
  var linguagensRepository = LinguagensRepository();
  var linguagens = [];
  List<String> linguagensSelecionadas = [];
  double pretensaoSalarial = 2000;
  int tempoExperiencia = 0;
  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  void carregarDados() async{
    dadosCadastraisRepository = await DadosCadastraisRepository.abrirCaixa();
    dadosCadastraisModel = dadosCadastraisRepository.carregarDados();
    setState(() {
      nomeController.text = dadosCadastraisModel.nome ?? "";
      dataNascimentoController.text = dadosCadastraisModel.dataNascimento.toString();
      nivelSelecionado = dadosCadastraisModel.nivelSelecionado ?? "" ;
      linguagensSelecionadas = dadosCadastraisModel.linguagens ;
      tempoExperiencia = dadosCadastraisModel.tempoExperiencia ?? 0;
      pretensaoSalarial = dadosCadastraisModel.pretensaoSalarial ?? 700;
    });
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(DropdownMenuItem(
        child: Text(i.toString()),
        value: i,
      ));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold( 
        appBar: AppBar(title: const Text("Meus Dados"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextLabel(texto: "Nome" ),
                    TextField(
                      controller: nomeController,
                    ),
                    const TextLabel(texto: "Data de Nascimento"),
                    TextField(
                      controller: dataNascimentoController,
                      readOnly: true,
                      onTap: () async {
                        var data = await showDatePicker(context: context, 
                        firstDate: DateTime(1929,1,1),
                        lastDate: DateTime.now(),
                        initialDate: DateTime(2000,1,1)
                        );
                        if(data != null){
                          dataNascimentoController.text = data.toString();
                        }
                      },
                    ),
                    const TextLabel(texto: "Nivel de experiencia" ),
                    Column( children: 
                      niveis.map( (item) => 
                        RadioListTile(
                          value: item, 
                          title: Text(item), 
                          groupValue: nivelSelecionado, 
                          onChanged: (value){ setState(() {
                            nivelSelecionado = value; 
                          }); })
                       ).toList()
                       ),
                   const TextLabel(texto: "Linguagens Preferidas" ),
                    Column(
                      children: 
                        linguagens.map( (linguagem) =>
                          CheckboxListTile( 
                          title: Text(linguagem), 
                          value: linguagensSelecionadas.contains(linguagem), 
                          onChanged: (bool? value){
                            if (value!) {
                            setState(() {
                              linguagensSelecionadas.add(linguagem);
                            });
                          } else {
                            setState(() {
                              linguagensSelecionadas.remove(linguagem);
                            });
                          } }
                        )
                        ).toList(),
                    ) ,
                    const TextLabel(texto: "Tempo de Experiencia em anos" ),
                    DropdownButton(
                    value: tempoExperiencia,
                    isExpanded: true,
                    items: returnItens(7), 
                    onChanged: (value){
                      setState(() {
                       tempoExperiencia = int.parse(value.toString());
                      });
                    } ),
                    TextLabel(texto: "Pretensao Salarial R\$ ${pretensaoSalarial.round().toString()}" ),
                     Slider(value: pretensaoSalarial, min: 700 , max: 7000, onChanged: (value) {
                      setState(() {
                        pretensaoSalarial = value;
                      });
                     } ),
                    TextButton(onPressed: (){
                      if(nomeController.text.length < 3){
                        ScaffoldMessenger.of(context).showSnackBar( 
                          const SnackBar(content: Text("Nome deve ser preenchido"))
                        );
                        return;
                      }
                      //utilizar validações mais atuais
                       setState(() {
                        salvando = true;
                      });

                      Future.delayed(const Duration(seconds: 2), () async{
                         ScaffoldMessenger.of(context).showSnackBar( 
                          const SnackBar(content: Text("Dados salvos com sucesso"))
                        );

                         setState(() {
                          salvando = false;
                        });
 
                        dadosCadastraisRepository.salvar(dadosCadastraisModel);
                        Navigator.pop(context);
                      });
                    }, 
                      child: const Text("salvar"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ), 
    );
  }
}
