import 'dart:math';
import 'package:cobras_e_escadas/constants/app_theme.dart';
import 'package:cobras_e_escadas/constants/dados_constants.dart';
import 'package:cobras_e_escadas/dialogs/dialogo_fim_de_jogo.dart';
import 'package:cobras_e_escadas/overlays/mostrar_resultado_overlay.dart';
import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:cobras_e_escadas/overlays/rolar_dados_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:spring/spring.dart';

class BotaoJogarDados extends StatefulWidget {
  BotaoJogarDados({Key key}) : super(key: key);

  @override
  _BotaoJogarDadosState createState() => _BotaoJogarDadosState();
}

class _BotaoJogarDadosState extends State<BotaoJogarDados> {
  List<ReactionDisposer> disposer = [];
  RolarDadosOverlay rolarDadosOverlay;
  OverlayEntry rolarDadosOverlayEntry;
  MostrarResultadoOverlay mostrarResultadoOverlay;
  OverlayEntry mostrarResultadoOverlayEntry;
  CobrasEscadas cobrasEscadasStore;
  int dadoUm;
  int dadoDois;

  @override
  void initState() {
    super.initState();
    cobrasEscadasStore = GetIt.instance<CobrasEscadas>();
    ;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    disposer.add(
      reaction(
        (_) => cobrasEscadasStore.rolandoDados,
        (rolandoDados) async {
          //Cria um overlay para animar o rolamento de dados
          cobrasEscadasStore.prontoParaUmaJogada(delay: false);
          rolarDadosOverlay =
              RolarDadosOverlay(dadoUm: dadoUm, dadoDois: dadoDois);
          rolarDadosOverlayEntry = rolarDadosOverlay.mostrarDados(context);
          Navigator.of(context).overlay.insert(rolarDadosOverlayEntry);

          await Future.delayed(Duration(milliseconds: 2000));

          rolarDadosOverlayEntry.remove();
        },
      ),
    );

    disposer.add(
      reaction(
        (_) => cobrasEscadasStore.resultadoDisponivel,
        (resultadoDisponivel) async {
          //Cria um overlay para animar a exibição do resultado
          await Future.delayed(Duration(milliseconds: 2000));

          mostrarResultadoOverlay = cobrasEscadasStore.jogadorAtual == 1
              ? MostrarResultadoOverlay(
                  resultado:
                      cobrasEscadasStore.posicaoJogadorUm + dadoUm + dadoDois,
                  jogador: cobrasEscadasStore.jogadorAtual,
                  fadeIn: true)
              : MostrarResultadoOverlay(
                  resultado:
                      cobrasEscadasStore.posicaoJogadorDois + dadoUm + dadoDois,
                  jogador: cobrasEscadasStore.jogadorAtual,
                  fadeIn: true);
          mostrarResultadoOverlayEntry =
              mostrarResultadoOverlay.mostrarResultado(context);
          Navigator.of(context).overlay.insert(mostrarResultadoOverlayEntry);

          await Future.delayed(Duration(milliseconds: 2000));
          cobrasEscadasStore.jogar(dadoUm, dadoDois, context);
          mostrarResultadoOverlayEntry.remove();
          cobrasEscadasStore.prontoParaUmaJogada(delay: false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final random = new Random();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Observer(
              builder: (BuildContext context) {
                return cobrasEscadasStore.turnoSendoComputado
                    ? SizedBox()
                    : Spring.slide(
                        slideType: SlideType.slide_in_bottom,
                        animDuration: Duration(
                          milliseconds: 300,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (cobrasEscadasStore.posicaoJogadorUm == 100 ||
                                cobrasEscadasStore.posicaoJogadorDois == 100) {
                              DialogoFimDeJogo.dialogoFimDeJogo(context);
                            } else {
                              dadoUm = 1 + random.nextInt(5);
                              dadoDois = 1 + random.nextInt(5);

                              cobrasEscadasStore.rolarDados();
                              cobrasEscadasStore.mostrarResultado();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.asset(
                              DadosConstants.dado_icone,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor)),
                        ),
                      );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    disposer.forEach((disposer) {
      disposer();
    });
    super.dispose();
  }
}
