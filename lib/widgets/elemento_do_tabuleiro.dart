import 'package:cobras_e_escadas/constants/elementos_do_tabuleiro_constants.dart';
import 'package:flutter/material.dart';

class ElementoDoTabuleiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -40,
          left: 110,
          child: Image.asset(
            ElementosDoTabuleiroConstants.cobra,
            height: 300,
            width: 100,
          ),
        ),
        Positioned(
          bottom: 165,
          left: 180,
          child: Image.asset(
            ElementosDoTabuleiroConstants.cobra_quatro,
            height: 300,
            width: 100,
          ),
        ),
        Positioned(
          top: 200,
          left: 30,
          child: Image.asset(
            ElementosDoTabuleiroConstants.cobra_dois,
            height: 300,
            width: 100,
          ),
        ),
        Positioned(
          top: 40,
          left: 220,
          child: Image.asset(
            ElementosDoTabuleiroConstants.cobra_tres,
            height: 300,
            width: 100,
          ),
        ),
        Positioned(
          top: 180,
          left: 20,
          child: Image.asset(
            ElementosDoTabuleiroConstants.escada,
            height: 100,
            width: 100,
          ),
        ),
        Positioned(
          top: 20,
          right: 40,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(150 / 360),
            child: Image.asset(
              ElementosDoTabuleiroConstants.escada,
              height: 100,
              width: 100,
            ),
          ),
        ),
        Positioned(
          top: 300,
          right: 160,
          child: RotationTransition(
            turns: AlwaysStoppedAnimation(150 / 360),
            child: Image.asset(
              ElementosDoTabuleiroConstants.escada,
              height: 100,
              width: 100,
            ),
          ),
        ),
      ],
    );
  }
}
