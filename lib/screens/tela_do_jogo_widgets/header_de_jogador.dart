import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cobras_e_escadas/constants/app_theme.dart';
import 'package:cobras_e_escadas/constants/audio_constants.dart';
import 'package:cobras_e_escadas/constants/jogador_constants.dart';
import 'package:cobras_e_escadas/dialogs/dialogo_reiniciar.dart';
import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:spring/spring.dart';

class MenuDeJogador extends StatefulWidget {
  const MenuDeJogador({Key key, this.numJogador}) : super(key: key);
  final String numJogador;

  @override
  _MenuDeJogadorState createState() => _MenuDeJogadorState();
}

class _MenuDeJogadorState extends State<MenuDeJogador> {
  CobrasEscadas _cobrasEscadasStore;
  AudioCache _audioCache;
  AudioPlayer _player;

  @override
  void initState() {
    _cobrasEscadasStore = GetIt.instance<CobrasEscadas>();
    _audioCache = GetIt.instance<AudioCache>();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _playAssetMusic();
    });
  }

  _playAssetMusic() async {
    _player = await _audioCache.play(AudioConstants.musica_de_fundo);

    _player.onPlayerCompletion.listen((event) async {
      _player = await _audioCache.play(AudioConstants.musica_de_fundo);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    DialogoReiniciar dialogo = new DialogoReiniciar();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spring.slide(
            slideType: SlideType.slide_in_top,
            animDuration: Duration(
              milliseconds: 300,
            ),
            child: Container(
              width: 300,
              height: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Jogador ${widget.numJogador}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 80,
                      child: Image.asset(
                        JogadorConstants.parado(widget.numJogador),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: secondaryColor),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: primaryColor),
                ],
              ),
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  dialogo.dialogoReiniciar(context);
                },
                child: Icon(
                  Icons.autorenew,
                  color: secondaryColor,
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
              ),
              ElevatedButton(
                onPressed: () async {
                  _cobrasEscadasStore.musicaTocando
                      ? await _player.stop()
                      : await _playAssetMusic();
                  _cobrasEscadasStore.desligarMusica();
                },
                child: Observer(
                  builder: (BuildContext context) {
                    return _cobrasEscadasStore.musicaTocando
                        ? Icon(
                            Icons.volume_up_rounded,
                            color: secondaryColor,
                          )
                        : Icon(
                            Icons.volume_off_rounded,
                            color: secondaryColor,
                          );
                  },
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
