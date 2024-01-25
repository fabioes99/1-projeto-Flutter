import 'dart:io';

import 'package:_1_projeto/model/contatos.dart';
import 'package:_1_projeto/pages/contatos/contatos_listview.dart';
import 'package:_1_projeto/repositories/back4app/contatos_lista.dart';
import 'package:_1_projeto/shared/widgets/text_label.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

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
  bool updateLista = false;
  String pathPhotoUpdate = '';
  String pathPhotoPost = '';

    @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.9;
      if (_scrollController.position.pixels > posicaoParaPaginar) {
        carregarDados(false);
      }
    });
    super.initState();
    carregarDados(false);
  }

  carregarDados(bool updateLista) async {
    if (carregando) return;
    if ( listaContatosModel.listaContatos.isEmpty || updateLista ) {
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
                    Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: pathPhotoPost == '' 
                          ? const Center(
                            child: Text(
                                'No image',
                                style: TextStyle(fontSize: 12),
                              ),
                          )
                          : CircleAvatar(
                              backgroundImage: FileImage(File(pathPhotoPost)),
                              radius: 200.0,
                            ),
                      )),
                    TextButton(
                      onPressed: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Wrap(
                                children: [
                                  ListTile(
                                    leading: const FaIcon(FontAwesomeIcons.camera),
                                    title: const Text("Camera"),
                                    onTap: () async {
                                      final ImagePicker _picker = ImagePicker();
                                      photo = await _picker.pickImage(
                                          source: ImageSource.camera);
                                      if (photo != null) {
                                        String path = (await path_provider
                                                .getApplicationDocumentsDirectory())
                                            .path;
                                        String name = basename(photo!.path);
                                        await photo!.saveTo("$path/$name");
                                        await GallerySaver.saveImage(photo!.path);
                                        setState(() {
                                          pathPhotoPost = photo!.path;
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                  ListTile(
                                      leading: const FaIcon(FontAwesomeIcons.images),
                                      title: const Text("Galeria"),
                                      onTap: () async {
                                        final ImagePicker _picker = ImagePicker();
                                        photo = await _picker.pickImage(
                                            source: ImageSource.gallery);
                                        setState(() {
                                          pathPhotoPost = photo!.path;
                                        });   
                                        Navigator.pop(context);
                                       
                                      })
                                ],
                              );
                            });
                      },
                    child: const Text("Tirar Foto")),
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
                  listaContatosRepository.post(ContatoModel( pathPhoto: pathPhotoPost , nome: nomePost.text, telefone: telefonePost.text, cpf: cpfPost.text, email:  emailPost.text));
                  Navigator.pop(context); 
                  carregarDados(false);
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
                    carregarDados(true);
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
              Expanded(
                child: ContatosList(
                contatos: listaContatosModel.listaContatos,
                onDelete: (contato) async {
                  await listaContatosRepository.delete(contato.objectId!);
                  listaContatosModel.listaContatos.remove(contato);
                  carregarDados(false);
                },
                onEdit: (contato) {
                  showDialog(
                    context: context,
                    builder: (BuildContext bc) {
                      var nomeController = TextEditingController();
                      var emailController = TextEditingController();
                      var telefoneController = TextEditingController();
                      var cpfController = TextEditingController();
                      nomeController.text = contato.nome ?? '';
                      emailController.text = contato.email ?? '';
                      telefoneController.text = contato.telefone ?? '';
                      cpfController.text = contato.cpf ?? '';
                      pathPhotoUpdate = contato.pathPhoto ?? '';
                      return AlertDialog(
                        title: const Text("Editar Contato"),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 120.0,
                                width: 120.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                  child: pathPhotoUpdate == '' 
                                    ? const Center(
                                      child: Text(
                                          'No image',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                    )
                                    : CircleAvatar(
                                        backgroundImage: FileImage(File(pathPhotoUpdate)),
                                        radius: 200.0,
                                      ),
                                )),
                              TextButton(
                                onPressed: () async {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return Wrap(
                                          children: [
                                            ListTile(
                                              leading: const FaIcon(FontAwesomeIcons.camera),
                                              title: const Text("Camera"),
                                              onTap: () async {
                                                final ImagePicker _picker = ImagePicker();
                                                photo = await _picker.pickImage(
                                                    source: ImageSource.camera);
                                                if (photo != null) {
                                                  String path = (await path_provider
                                                          .getApplicationDocumentsDirectory())
                                                      .path;
                                                  String name = basename(photo!.path);
                                                  await photo!.saveTo("$path/$name");
                                                  await GallerySaver.saveImage(photo!.path);
                                                  setState(() {
                                                    pathPhotoUpdate = photo!.path;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                            ),
                                            ListTile(
                                                leading: const FaIcon(FontAwesomeIcons.images),
                                                title: const Text("Galeria"),
                                                onTap: () async {
                                                  final ImagePicker _picker = ImagePicker();
                                                  photo = await _picker.pickImage(
                                                      source: ImageSource.gallery);
                                                  setState(() {
                                                    pathPhotoUpdate = photo!.path;
                                                  });   
                                                  Navigator.pop(context);
                                                
                                                })
                                          ],
                                        );
                                      });
                                },
                              child: const Text("Tirar Foto")),
                              const TextLabel(texto: "Nome"),
                              TextField(controller: nomeController, ),
                              const TextLabel(texto: "Email"),
                              TextField(controller: emailController,),
                              const TextLabel(texto: "Telefone"),
                              TextField(controller: telefoneController,),
                              const TextLabel(texto: "CPF"),
                              TextField(controller: cpfController,),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await listaContatosRepository.update(
                                ContatoModel(
                                  objectId: contato.objectId,
                                  nome: nomeController.text,
                                  cpf: cpfController.text,
                                  email: emailController.text,
                                  telefone: telefoneController.text,
                                  pathPhoto: pathPhotoUpdate,
                                ),
                              );
                              Navigator.pop(context);
                              carregarDados(true);
                            },
                            child: const Text('Salvar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ),
              !carregando
              ? ElevatedButton(
                  onPressed: () {
                    carregarDados(false);
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