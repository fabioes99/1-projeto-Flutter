import 'package:flutter/material.dart';
import 'package:_1_projeto/model/characters.dart';
import 'package:_1_projeto/repositories/marvel/marvel_api.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final ScrollController _scrollController = ScrollController();
  late MarvelApiRepository marvelRepository;
  CharactersModel herois = CharactersModel();
  int offset = 0;
  var carregando = false;
  @override
  void initState() {
    _scrollController.addListener(() {
      var posicaoParaPaginar = _scrollController.position.maxScrollExtent * 0.7;
      if (_scrollController.position.pixels > posicaoParaPaginar) {
        carregarDados();
      }
    });
    marvelRepository = MarvelApiRepository();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    if (carregando) return;
    if (herois.data == null || herois.data!.results == null) {
      herois = await marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        carregando = true;
      });
      offset = offset + herois.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      herois.data!.results!.addAll(tempList.data!.results!);
      carregando = false;
    }
    setState(() {});
  }

  int retornaQuantidadeTotal() {
    try {
      return herois.data!.total!;
    } catch (e) {
      return 0;
    }
  }

  int retornaQuantidadeAtual() {
    try {
      return offset + herois.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
            "Heróis: ${retornaQuantidadeAtual()}/${retornaQuantidadeTotal()}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                itemCount: (herois.data == null ||
                        herois.data!.results == null)
                    ? 0
                    : herois.data!.results!.length,
                itemBuilder: (_, int index) {
                  var character = herois.data!.results![index];
                  return Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          '${character.thumbnail!.path!}.${character.thumbnail!.extension!}',
                          width: 150,
                          height: 150,
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(character.description!),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          !carregando
              ? ElevatedButton(
                  onPressed: () {
                    carregarDados();
                  },
                  child: const Text("Carregar mais itens"))
              : const CircularProgressIndicator()
        ],
      ),
    ));
  }
}