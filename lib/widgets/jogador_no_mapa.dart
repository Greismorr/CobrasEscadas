import 'package:cobras_e_escadas/widgets/avatar_do_jogador.dart';
import 'package:flutter/material.dart';

class JogadorNoMapa extends StatelessWidget {
  const JogadorNoMapa(
      {Key key,
      this.index,
      this.totalJogadorUm,
      this.totalJogadorDois,
      this.jogadorAtual})
      : super(key: key);
  final int index, totalJogadorUm, totalJogadorDois, jogadorAtual;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (totalJogadorUm == (100 - index))
          AvatarDoJogador(
            player: 1,
            size: totalJogadorUm == totalJogadorDois ? 8 : 3,
          ),
        if (totalJogadorDois == (100 - index))
          AvatarDoJogador(
            player: 2,
            size: 3,
          )
      ],
    );
  }
}
