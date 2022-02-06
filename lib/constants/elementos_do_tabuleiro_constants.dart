import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';

class ElementosDoTabuleiroConstants {
  static String caverna = 'assets/caverna.png';
  static String cobra = 'assets/cobra.png';
  static String cobra_dois = 'assets/cobra_dois.png';
  static String cobra_tres = 'assets/cobra_tres.png';
  static String cobra_quatro = 'assets/cobra_quatro.png';
  static String escada = 'assets/escada.png';
  static List<Color> cores = [
    Colors.red[100],
    Colors.pink[200],
    Colors.yellow[200],
    Colors.orange[200],
    Colors.cyan[200],
    Colors.purple[200],
    Colors.green[200],
    Colors.brown[200],
    Colors.teal[200],
  ];

  static List cobrasEscadas = [
    {
      'posicao': 36,
      'posicaoFutura': 18,
      'titulo': 'Eita... ' + Demoji.snake,
      'mensagem':
          ' terá que voltar para a casa 18, você caiu na cabeça de uma cobra.'
    },
    {
      'posicao': 41,
      'posicaoFutura': 23,
      'titulo': 'Que azar... ' + Demoji.snake,
      'mensagem':
          ' terá que voltar para a casa 23, você caiu na cabeça de uma cobra.'
    },
    {
      'posicao': 67,
      'posicaoFutura': 49,
      'titulo': 'Que triste... ' + Demoji.snake,
      'mensagem':
          ' terá que voltar para a casa 49, você caiu na cabeça de uma cobra.'
    },
    {
      'posicao': 88,
      'posicaoFutura': 70,
      'titulo': 'Dinossaurinho azarado... ' + Demoji.snake,
      'mensagem':
          ' terá que voltar para a casa 70, você caiu na cabeça de uma cobra.'
    },
    {
      'posicao': 15,
      'posicaoFutura': 34,
      'titulo': 'Dinossaurinho sortudo! ' + Demoji.four_leaf_clover,
      'mensagem': ' irá para a casa 34, você caiu na base de uma escada.'
    },
    {
      'posicao': 45,
      'posicaoFutura': 63,
      'titulo': 'Dinossaurinho sortudo! ' + Demoji.four_leaf_clover,
      'mensagem': ' irá para a casa 63, você caiu na base de uma escada.'
    },
    {
      'posicao': 75,
      'posicaoFutura': 94,
      'titulo': 'Um dia de sorte! ' + Demoji.four_leaf_clover,
      'mensagem': ' irá para a casa 94, você caiu na base de uma escada.'
    }
  ];
}
