import 'package:audioplayers/audio_cache.dart';
import 'package:cobras_e_escadas/screens/tela_do_jogo.dart';
import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Registra os Singletons utilizados no App
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<CobrasEscadas>(CobrasEscadas());
  getIt.registerSingleton<AudioCache>(AudioCache());

  //Faz a barra de status do android ficar transparente
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cobras e Escadas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black12,
        primarySwatch: Colors.blue,
      ),
      home: TelaDoJogo(),
    );
  }
}
