import 'package:cobras_e_escadas/constants/jogador_constants.dart';
import 'package:flutter/material.dart';

class AvatarDoJogador extends StatelessWidget {
  const AvatarDoJogador({Key key, this.player, this.size}) : super(key: key);
  final int player;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size),
      child: Container(
        height: 50,
        width: 50,
        child: Image.asset(
          JogadorConstants.correndo(player.toString()),
        ),
      ),
    );
  }
}
