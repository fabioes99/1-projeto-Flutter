import 'package:_1_projeto/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var senhaController = TextEditingController();
  bool verSenha = true;
  void onPressedFunction() {
      if(emailController.text.trim() == 'teste@123' && senhaController.text.trim() == '123'){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage() ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar( 
          const SnackBar(content: Text("Erro ao efetuar o login"))
        );
      }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
      backgroundColor: Colors.black87,
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
           if (event.runtimeType == RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.enter) {
            onPressedFunction();
          }
        },
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container( margin: const EdgeInsets.only(top: 30, bottom: 13), 
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(flex: 8,  child: Image.network("https://hermes.digitalinnovation.one/assets/diome/logo.png", )),
                        Expanded(child: Container())
                      ],
                    ) ),
                    Text("Ja tem cadastro?", style: GoogleFonts.roboto(fontSize: 34, color: Colors.white), ),
                    Text("Faca seu login e make the change_", style: GoogleFonts.roboto(fontSize: 19, color: Colors.white)),
                    const SizedBox(height: 30,),
                  Container( alignment: Alignment.center, height: 40, width: double.infinity, margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0) ,  
                  child: TextField(
                    controller: emailController,  
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 4),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.email, color:Color.fromARGB(255, 185, 102, 198))
                  ),
                )
                  ),
                  Container( alignment: Alignment.center, height: 40, width: double.infinity, margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0) , color: Colors.black12,
                   child: TextField(
                    obscureText: verSenha,
                    controller: senhaController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 4),
                      hintText: "Senha",
                      hintStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(Icons.lock, color:Color.fromARGB(255, 185, 102, 198)),
                      suffixIcon: InkWell( onTap: () { 
                        setState(() {
                          verSenha = !verSenha;   
                        });
                        }, child: Icon(  verSenha ? Icons.visibility_off : Icons.visibility, color:const Color.fromARGB(255, 185, 102, 198))),
                    ),
                  )
                   ),
                  Container( 
                    alignment: Alignment.center, 
                    height: 40, 
                    width: double.infinity, 
                    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 12) ,
                    child: 
                      SizedBox(
                        width: double.infinity, 
                        child: TextButton(
                          onPressed: onPressedFunction, 
                          style: ButtonStyle( 
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(Colors.purple) ),
                          child: Text('Entrar',style: GoogleFonts.roboto(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold)), 
                          ),
                      ) 
                    ),            
                  Expanded(child: Container()),
                  Container( alignment: Alignment.center, margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0) ,child: Text('Esqueci Minha Senha', style: GoogleFonts.roboto( color: Colors.yellow))),
                  Container( alignment: Alignment.center, margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 12) ,child: Text('Criar Conta', style: GoogleFonts.roboto( color: Colors.green))),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ) 
    ) ;
  }
}