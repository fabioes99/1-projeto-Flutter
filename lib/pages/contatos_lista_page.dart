import 'dart:io';

import 'package:_1_projeto/model/contatos.dart';
import 'package:_1_projeto/repositories/back4app/contatos_lista.dart';
import 'package:_1_projeto/shared/widgets/text_label.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  XFile? photo;
  final ScrollController _scrollController = ScrollController();
  ContatoModel contatoModel = ContatoModel();
  var listaContatosRepository = ListaContatosRepository();
  ListaContatosModel listaContatosModel = ListaContatosModel([]);
  bool loading = false;
  var carregando = false;
  int skip = 0;
  var nomeBuscaController = TextEditingController();
  String contatoNotFound = '';

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
    if ( listaContatosModel.listaContatos.isEmpty ) {
      listaContatosModel = await listaContatosRepository.obterContatos(skip);
    } else {
      setState(() {
        carregando = true;
      });
      skip = skip + listaContatosModel.listaContatos.length;
      var tempList = await listaContatosRepository.obterContatos(skip);
      listaContatosModel.listaContatos.addAll(tempList.listaContatos);
      carregando = false;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    
   return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Center(child: Text("Lista de Contatos")),),
        floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var pathPhotoPost = TextEditingController();
          var nomePost = TextEditingController();
          var telefonePost = TextEditingController();
          var cpfPost = TextEditingController();
          var emailPost = TextEditingController();
          showDialog(context: context, builder: (BuildContext bc) {
            return AlertDialog(
              title: const Text("Adicionar Contato"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    const TextLabel(texto: "Nome"),
                    TextField( controller: nomePost,),
                    const TextLabel(texto: "CPF"),
                    TextFormField( controller: cpfPost, inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ], decoration: const InputDecoration(hintText: '000.000.000-00'),),
                    const TextLabel(texto: "Telefone"),
                    TextFormField( controller: telefonePost, inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],),
                    const TextLabel(texto: "Email"),
                    TextField( controller: emailPost,),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () { Navigator.pop(context); }, child: const Text('Cancelar')),
                TextButton(onPressed: () { 
                  listaContatosRepository.post(ContatoModel( pathPhoto: pathPhotoPost.text, nome: nomePost.text, telefone: telefonePost.text, cpf: cpfPost.text, email:  emailPost.text));
                  Navigator.pop(context); 
                  carregarDados();
                  setState(() {});
                }, child: const Text('Salvar')),
              ],
            );
          });
        }),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
            TextFormField(
              controller: nomeBuscaController,
              onChanged: (String value) {
                if(value.isEmpty){
                  setState(() {  contatoNotFound = ''; });
                  if( listaContatosModel.listaContatos.length == 1 ){
                    carregarDados();
                  }
                }
              },
              ),
              const SizedBox( height: 17,),
              ElevatedButton(onPressed: () async{
                  setState(() {
                    contatoNotFound = '';
                    loading = true;
                  });
                  //contatoModel = await listaContatosRepository.getContato(nomeBuscaController.text);
                  bool temContatoLista = listaContatosModel.listaContatos.any((contato) => contato.nome == nomeBuscaController.text);
                  if(temContatoLista){
                    ContatoModel contatoEncontrado = listaContatosModel.listaContatos.firstWhere( (contato) => contato.nome == nomeBuscaController.text);
                    List<ContatoModel> listaContatoEncontrado = [contatoEncontrado];
                    listaContatosModel.listaContatos = listaContatoEncontrado;
                  }
                  else{
                    contatoNotFound = 'Não foi encontrado o contato';
                  }
                setState(() { loading = false; });
              }, child: 
               const Text("Pesquisar")
               ),
              Container(
                child: contatoNotFound.isNotEmpty ? 
                Text(contatoNotFound, style: const TextStyle(fontSize: 22)) : 
                loading ? 
                const Center(child: CircularProgressIndicator()) : const Text('')
              ),
                const SizedBox(
                height: 20,
              ),
              Expanded(child: ListView.builder(
                controller: _scrollController,
                itemCount: listaContatosModel.listaContatos.length,
                itemBuilder: (_, int index) {
                  var contato = listaContatosModel.listaContatos[index];
                  var pathPhotoController = TextEditingController(text: "");
                  var nomeController = TextEditingController(text: "");
                  var emailController= TextEditingController(text: "");
                  var cpfController = TextEditingController(text: "");
                  var telefoneController= TextEditingController(text: "");
                  pathPhotoController.text = contato.pathPhoto ?? '';
                  nomeController.text = contato.nome ?? '';
                  emailController.text = contato.email ?? '';
                  cpfController.text = contato.cpf ?? '';
                  telefoneController.text = contato.telefone ?? '';
                  
                  return Dismissible(
                    onDismissed: (DismissDirection dissmisDirection) async{
                      await listaContatosRepository.delete(contato.objectId!);
                      listaContatosModel.listaContatos.removeAt(index);
                      carregarDados();
                    },
                    key: Key(contato.objectId!),
                    child: 
                    InkWell(
                      onTap: () {
                      showDialog(context: context, builder: (BuildContext bc) {
                        return AlertDialog(
                        title: const Text("Editar Contato") ,
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              const TextLabel(texto: "Nome"),
                              TextField( controller: nomeController,),
                              const TextLabel(texto: "Email"),
                              TextField( controller: emailController,),
                               const TextLabel(texto: "Telefone"),
                              TextField( controller: telefoneController,),
                               const TextLabel(texto: "CPF"),
                              TextField( controller: cpfController,),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: () { Navigator.pop(context); }, child: const Text('Cancelar')),
                          TextButton(onPressed: () async{                           
                            await listaContatosRepository.update(
                              ContatoModel( 
                                objectId: contato.objectId, 
                                nome: nomeController.text,
                                cpf: cpfController.text,
                                email: emailController.text,
                                telefone: telefoneController.text, 
                                pathPhoto: pathPhotoController.text
                              ));
                          Navigator.pop(context); 
                          carregarDados();
                        }, child: const Text('Salvar')),
                        ],);
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
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 80.0,
                                        width: 80.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade200,
                                        ),
                                        child: Center(
                                          child: photo == null
                                            ? const Center(
                                              child: Text(
                                                  'No image',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                            )
                                            : CircleAvatar(
                                                backgroundImage: FileImage(File(photo!.path)),
                                                radius: 200.0,
                                              ),
                                        )),
                                         Text( " ${contato.nome} \n ${contato.telefone} \n ${contato.email} \n ${contato.cpf} " , style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                                    ], ),
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
                  child: const Text("Carregar mais Contatos"))
              : const CircularProgressIndicator() 
            ],
          ),
        ),
      ),
    );
  }
}