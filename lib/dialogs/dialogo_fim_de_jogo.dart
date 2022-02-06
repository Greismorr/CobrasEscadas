import 'package:cobras_e_escadas/constants/app_theme.dart';
import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';

class DialogoFimDeJogo {
  CobrasEscadas cobrasEscadasStore;

  static dialogoFimDeJogo(context) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Jogo já acabou...' + Demoji.warning,
            style: TextStyle(color: Colors.black54),
          ),
          content: Text(
            'Comece um novo jogo.',
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
