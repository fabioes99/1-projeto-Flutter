import 'package:_1_projeto/repositories/linguagens_repository.dart';
import 'package:_1_projeto/repositories/nivel_repository.dart';
import 'package:_1_projeto/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DadosCadastrais extends StatefulWidget {
 const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  DateTime? dataNascimento ;
  var nivelRepository = NivelRepository();
  var niveis = [];
  var nivelSelecionado = '';
  var linguagensRepository = LinguagensRepository();
  var linguagens = [];
  List<String> linguagensSelecionadas = [];
  double pretensaoSalarial = 2000;
  int tempoExperiencia = 0;
  bool salvando = false;

  late SharedPreferences storage;

  final CHAVE_NOME = 'nome';
  final CHAVE_DATA_NASCIMENTO = 'data_nascimento';
  final CHAVE_NIVEL = 'nivel';
  final CHAVE_LINGUAGENS = 'linguagens';
  final CHAVE_TEMPO_EXP = 'tempo_exp';
  final CHAVE_PRETENSAO_SALARIAL = 'pretensao_salarial';

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  void carregarDados() async{
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeController.text = storage.getString(CHAVE_NOME) ?? "";
      dataNascimentoController.text = (storage.getString(CHAVE_DATA_NASCIMENTO) ?? "");
      nivelSelecionado = storage.getString(CHAVE_NIVEL) ?? "";
      linguagensSelecionadas = storage.getStringList(CHAVE_LINGUAGENS) ?? [];
      tempoExperiencia = storage.getInt(CHAVE_TEMPO_EXP) ?? 0;
      pretensaoSalarial = storage.getDouble(CHAVE_PRETENSAO_SALARIAL) ?? 2000;
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
                        await storage.setString(CHAVE_NOME, nomeController.text);
                        await storage.setString(CHAVE_DATA_NASCIMENTO, dataNascimentoController.text);
                        await storage.setString(CHAVE_NIVEL, nivelSelecionado);
                        await storage.setStringList(CHAVE_LINGUAGENS, linguagensSelecionadas);
                        await storage.setInt(CHAVE_TEMPO_EXP, tempoExperiencia);
                        await storage.setDouble(CHAVE_PRETENSAO_SALARIAL, pretensaoSalarial);
 
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
