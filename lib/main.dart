import 'package:_1_projeto/model/dados_cadastrais_model.dart';
import 'package:_1_projeto/model/tarefa_hive.dart';
import 'package:_1_projeto/my_app.dart';
import 'package:_1_projeto/repositories/comments/comment_repository.dart';
import 'package:_1_projeto/repositories/comments/implement/comments_dio.dart';
import 'package:_1_projeto/repositories/jsonplaceholder_custom.dart';
import 'package:_1_projeto/repositories/posts/implement/posts_dio.dart';
import 'package:_1_projeto/repositories/posts/posts_repository.dart';
import 'package:_1_projeto/services/contador_mobx.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:_1_projeto/repositories/sqlite/sqlite_database.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;

setupGetit(){
  //vai ser criado apenas uma instancia no projeto inteiro
  //muito util para nao ter que criar uma nova cada vez que abre a pagina
  getIt.registerSingleton<ContadorMobxService>(ContadorMobxService());
  getIt.registerSingleton<JsonPlaceHolderCustonDio>(JsonPlaceHolderCustonDio());
  getIt.registerSingleton<PostsRepository>(PostsDio(getIt<JsonPlaceHolderCustonDio>()));
  getIt.registerSingleton<CommentsRepository>(CommentsDio(getIt<JsonPlaceHolderCustonDio>()));
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());
  SqliteDatabase database = SqliteDatabase();
  await database.iniciarBancoDeDados();
  await dotenv.load(fileName: ".env");

  setupGetit();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


