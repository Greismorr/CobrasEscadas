import 'package:cobras_e_escadas/constants/dados_constants.dart';
import 'package:cobras_e_escadas/widgets/dado_widget.dart';
import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class RolarDadosOverlay {
  final int dadoUm;
  final int dadoDois;

  const RolarDadosOverlay({Key key, this.dadoUm, this.dadoDois});

  OverlayEntry mostrarDados(BuildContext context) {
    return OverlayEntry(
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DadoWidget(
              dado: DadosConstants.dado(
                dadoUm.toString(),
              ),
              controladorSpring: SpringController(initialAnim: Motion.play),
              moverParaDireita: true,
            ),
            DadoWidget(
              dado: DadosConstants.dado(
                dadoDois.toString(),
              ),
              controladorSpring: SpringController(initialAnim: Motion.play),
              moverParaDireita: false,
            ),
          ],
        );
      },
    );
  }
}
