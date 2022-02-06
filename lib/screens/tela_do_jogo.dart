import 'package:audioplayers/audio_cache.dart';
import 'package:cobras_e_escadas/constants/app_theme.dart';
import 'package:cobras_e_escadas/constants/elementos_do_tabuleiro_constants.dart';
import 'package:cobras_e_escadas/constants/audio_constants.dart';
import 'package:cobras_e_escadas/screens/tela_do_jogo_widgets/jogar_dados.dart';
import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:cobras_e_escadas/widgets/elemento_do_tabuleiro.dart';
import 'package:cobras_e_escadas/widgets/jogador_no_mapa.dart';
import 'package:cobras_e_escadas/screens/tela_do_jogo_widgets/header_de_jogador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:spring/spring.dart';

class TelaDoJogo extends StatefulWidget {
  const TelaDoJogo({Key key}) : super(key: key);

  @override
  _TelaDoJogoState createState() => _TelaDoJogoState();
}

class _TelaDoJogoState extends State<TelaDoJogo> {
  CobrasEscadas _cobrasEscadasStore;

  @override
  void initState() {
    _cobrasEscadasStore = GetIt.instance<CobrasEscadas>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var corAntiga;

    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Observer(
              name: "Player",
              builder: (BuildContext context) {
                return MenuDeJogador(
                  numJogador: _cobrasEscadasStore.jogadorAtual.toString(),
                );
              },
            ),
            Expanded(
              child: AnimationLimiter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: primaryColor),
                          ],
                        ),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(12),
                          addAutomaticKeepAlives: true,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 9),
                          itemCount: 100,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            ElementosDoTabuleiroConstants.cores.shuffle();
                            var cor = ElementosDoTabuleiroConstants.cores[0];

                            //Necessário para que cores não se repitam em posições
                            //adjacentes
                            if (corAntiga == cor) {
                              cor = ElementosDoTabuleiroConstants.cores[1];
                            }

                            if ((100 - index) == 1) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((_) async {
                                await _cobrasEscadasStore.prontoParaUmaJogada(
                                    delay: true);
                              });
                            }

                            corAntiga = cor;

                            return Container(
                              child: AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                columnCount: 1,
                                child: ScaleAnimation(
                                  child: Observer(
                                    builder: (BuildContext context) {
                                      return Stack(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration:
                                                BoxDecoration(color: cor),
                                            child: Center(
                                              child: (100 - index) == 100
                                                  ? Image.asset(
                                                      ElementosDoTabuleiroConstants
                                                          .caverna,
                                                    )
                                                  : Text(
                                                      (100 - index).toString(),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                            ),
                                          ),
                                          JogadorNoMapa(
                                            totalJogadorUm: _cobrasEscadasStore
                                                .posicaoJogadorUm,
                                            totalJogadorDois:
                                                _cobrasEscadasStore
                                                    .posicaoJogadorDois,
                                            jogadorAtual: _cobrasEscadasStore
                                                .jogadorAtual,
                                            index: index,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      FutureBuilder(
                        future: Future.delayed(Duration(seconds: 5)),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Spring.fadeIn(
                              child: ElementoDoTabuleiro(),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                      BotaoJogarDados(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
