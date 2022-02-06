import 'package:cobras_e_escadas/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class MostrarResultadoOverlay {
  final int resultado;
  final int jogador;
  final bool fadeIn;

  const MostrarResultadoOverlay(
      {Key key, this.resultado, this.jogador, this.fadeIn});

  OverlayEntry mostrarResultado(BuildContext context) {
    return OverlayEntry(
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: fadeIn
              ? Spring.fadeIn(
                  animDuration: Duration(milliseconds: 350),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: resultado < 100
                              ? Text(
                                  "Jogador $jogador andou até a casa ${resultado.toString()}!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                )
                              : Text(
                                  "Jogador $jogador se distraiu e passou da caverna. Voltando...!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                )
              : Spring.fadeOut(
                  animDuration: Duration(milliseconds: 350),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Ande ${resultado.toString()} Casas!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
