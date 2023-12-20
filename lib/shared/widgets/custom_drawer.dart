import 'package:_1_projeto/pages/dados_cadastrais.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell( onTap: () {
                showModalBottomSheet(context: context,
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                 builder: (BuildContext bc) {
                  return  Column(children: [
                    ListTile(
                      title: Text("Camera"),
                      leading: Icon(Icons.camera),
                        onTap: () {
                         Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text("Galeria"),
                      leading: Icon(Icons.album),
                      onTap: () {
                         Navigator.pop(context);
                      },
                    ),
                  ],);
                });}, 
                child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.purple.shade400),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(
                      "https://hermes.digitalinnovation.one/assets/diome/logo.png"),
                ),
                accountName: const Text("fabioes"), 
                accountEmail: const Text("teste@123")),
              ),
               const Divider(),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 5),
                        Text("dados cadatrais"),
                      ],
                    )),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DadosCadastrais() ));
                    },
                ),
                 const Divider(),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 5),
                        Text("Termos de Uso"),
                      ],
                    )),
                    onTap: (){
                      showModalBottomSheet(context: context, builder: (BuildContext bc){
                        return Container(
                          padding: const EdgeInsets.symmetric( vertical: 16, horizontal: 12),
                          child: const Column(
                            children: [
                            Text(
                              "Termos de uso e privacidade",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                              Text( "Do mesmo modo, o entendimento das metas propostas prepara-nos para enfrentar situações atípicas decorrentes do sistema de formação de quadros que corresponde às necessidades. Todas estas questões, devidamente ponderadas, levantam dúvidas sobre se a consolidação das estruturas acarreta um processo de reformulação e modernização dos conhecimentos estratégicos para atingir a excelência. Assim mesmo, a revolução dos costumes deve passar por modificações independentemente dos índices pretendidos. Não obstante, a percepção das dificuldades apresenta tendências no sentido de aprovar a manutenção do retorno esperado a longo prazo.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      });
                    },
                ),
                 const Divider(),
                 InkWell(
                  child: Container(
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(Icons.album),
                        SizedBox(width: 5),
                        Text("Configuracoes"),
                      ],
                    )
                  ),
                ),
                const Divider(),
              ],
          ),
        );
  }
}