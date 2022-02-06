import 'package:cobras_e_escadas/constants/app_theme.dart';
import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';

class DialogoVitoria {
  CobrasEscadas cobrasEscadasStore;

  static dialogoVitoria(context, player) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Parabéns, você ganhou ' + Demoji.star2,
            style: TextStyle(color: Colors.black54),
          ),
          content: Text(
            'Jogador ' + player.toString() + ' é o vencedor!',
            style: TextStyle(color: Colors.black45),
          ),
          
          backgroundColor: Colors.blue[200],
          elevation: 10,
          actions: [
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(),
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        );
      },
    );
  }
}
