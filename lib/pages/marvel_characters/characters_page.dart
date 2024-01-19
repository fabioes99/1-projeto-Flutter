import 'package:_1_projeto/model/characters.dart';
import 'package:_1_projeto/repositories/marvel/marvel_api.dart';
import 'package:flutter/material.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  CharactersModel herois = CharactersModel();
  late MarvelApiRepository marvelApi;
 
  int offset = 20;

  @override
  void initState() {    
    super.initState();
    marvelApi = MarvelApiRepository();
    carregarDados();
  }

  void carregarDados() async{
    herois = await marvelApi.getCharacters(offset);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Heróis'),),
        body: Container(
          child: ListView.builder(
            itemCount: (herois.data == null || herois.data!.results == null
             ? 0 : herois.data!.results!.length ),
            itemBuilder: (_, int index){
              var heroisData = herois.data!.results![index];
              return Card( child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Image.network(
                  '${heroisData.thumbnail?.path ?? ''}.${heroisData.thumbnail?.extension ?? ''}',
                  width: 150, height: 150,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(heroisData.name!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                          Text(heroisData.description!),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),);
            }
            ,),
        ),
      ),
    );
  }
}