import 'package:_1_projeto/services/gerar_numero_aleatorio.dart' ;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int numeroAleatorio = 0;
  int qtdeCliques = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meu app",
          //style: GoogleFonts.pacifico(),
        ),
        backgroundColor: Colors.black87,
        //style: GoogleFonts.
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            
              Container(
                color: Colors.black12,
                child: Text("O numero gerado eh: $numeroAleatorio",
                 style: GoogleFonts.roboto(fontSize: 22.0),),
              ),
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: Text("A quantidade clicada: $qtdeCliques",
                   style: GoogleFonts.roboto(fontSize: 22.0),),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Container( color: Colors.red, child: Text("10", style: GoogleFonts.acme(fontSize: 20),)) ),
                      Expanded(child: Container( color: Colors.blue, child: Text("20", style: GoogleFonts.acme(fontSize: 20),))),
                      Expanded(child: Container( color: Colors.amber, child: Text("30", style: GoogleFonts.acme(fontSize: 20),))),
                    ],
                   ),
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState( () {
            qtdeCliques += 1;
            numeroAleatorio = GeradorNumeroAleatorio.gerarNumeroAleatorio();
          } );          
        },
      ),
    );
  }
}