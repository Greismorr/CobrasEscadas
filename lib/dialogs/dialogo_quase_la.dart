import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DialogoQuaseLa {
  CobrasEscadas cobrasEscadasStore;

  dialogoQuaseLa(context, player, total) {
    this.cobrasEscadasStore = GetIt.instance<CobrasEscadas>();
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Você quase ganhou ' + Demoji.boom,
            style: TextStyle(color: Colors.black54),
          ),
          content: Text(
            'Jogador ' +
                player.toString() +
                ' precisa tirar exatamente o número de casas restantes, você irá retornar o número de casas que sobraram!',
            style: TextStyle(color: Colors.black45),
          ),
          backgroundColor: Colors.blue[200],
          elevation: 10,
          actions: [
            TextButton(
                onPressed: () => {
                      Navigator.of(context).pop(),
                      cobrasEscadasStore.moverJogador(
                          player, (100 - (total - 100)))
                    },
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        );
      },
    );
  }
}
