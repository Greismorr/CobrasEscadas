import 'package:cobras_e_escadas/constants/jogador_constants.dart';
import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DialogoEventoNoMapa {
  CobrasEscadas cobrasEscadasStore;

  dialogEventoNoMapa(context, element, currentPlayer) {
    this.cobrasEscadasStore = GetIt.instance<CobrasEscadas>();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            element.first['titulo'],
            style: TextStyle(color: Colors.black54),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Jogador ' +
                    currentPlayer.toString() +
                    element.first['mensagem'],
                style: TextStyle(color: Colors.black45),
              ),
              Container(
                width: 100,
                height: 80,
                child: element.first['titulo'].toString().contains(Demoji.snake)
                    ? Image.asset(
                        JogadorConstants.picado(currentPlayer),
                      )
                    : Image.asset(
                        JogadorConstants.subindo_escadas(currentPlayer),
                      ),
              )
            ],
          ),
          backgroundColor: Colors.blue[200],
          elevation: 10,
          actions: [
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(),
                this
                    .cobrasEscadasStore
                    .moverJogador(currentPlayer, element.first['posicaoFutura'])
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
