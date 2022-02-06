import 'package:cobras_e_escadas/constants/app_theme.dart';
import 'package:cobras_e_escadas/stores/cobras_escadas.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DialogoReiniciar {
  CobrasEscadas cobrasEscadasStore;

  dialogoReiniciar(context) {
    this.cobrasEscadasStore = GetIt.instance<CobrasEscadas>();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Deseja iniciar um novo jogo?',
            style: TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.blue[200],
          elevation: 10,
          actions: [
            TextButton(
              onPressed: () => {
                Navigator.of(context).pop(),
              },
              child: Text(
                "Não",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
                onPressed: () => {
                      Navigator.of(context).pop(),
                      this.cobrasEscadasStore.reiniciarPartida()
                    },
                child: Text(
                  "Sim",
                  style: TextStyle(color: Colors.black),
                )),
          ],
        );
      },
    );
  }
}
