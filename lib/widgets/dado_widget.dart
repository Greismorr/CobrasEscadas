import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class DadoWidget extends StatefulWidget {
  const DadoWidget(
      {Key key, this.dado, this.controladorSpring, this.moverParaDireita})
      : super(key: key);
  final String dado;
  final SpringController controladorSpring;
  final bool moverParaDireita;

  @override
  _DadoWidgetState createState() => _DadoWidgetState();
}

class _DadoWidgetState extends State<DadoWidget> with TickerProviderStateMixin {
  AnimationController controleAnimacaoCimaParaBaixo;
  AnimationController controleAnimacaoUnir;
  Animation<Offset> animacaoCimaParaBaixo;
  Animation<Offset> animacaoUnir;
  Animation<Offset> animacaoVirarNumero;
  var animacaoAtual;
  bool rodarDados = true;
  bool dadosDevemSeUnir = false;

  @override
  void initState() {
    super.initState();

    controleAnimacaoCimaParaBaixo = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    animacaoCimaParaBaixo =
        Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: controleAnimacaoCimaParaBaixo, curve: Curves.bounceInOut),
    );

    //Depois que os dados caírem até o centro da tela, eles devem se juntar
    controleAnimacaoCimaParaBaixo.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          animacaoAtual = animacaoUnir;
          controleAnimacaoUnir.forward();
        }
      },
    );

    controleAnimacaoUnir = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    animacaoUnir = Tween<Offset>(
            begin: Offset.zero,
            end: widget.moverParaDireita ? Offset(1.0, 0.0) : Offset(-1.0, 0.0))
        .animate(
      CurvedAnimation(parent: controleAnimacaoUnir, curve: Curves.bounceInOut),
    );

    //Depois que os dados se juntarem, eles devem sumir. Estou usando o controlador
    //da animação cima para baixo porque assim a animação de sumir começa assim
    //que os dados se juntam.
    controleAnimacaoCimaParaBaixo.addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          dadosDevemSeUnir = true;
        }
      },
    );

    animacaoAtual = animacaoCimaParaBaixo;
    controleAnimacaoCimaParaBaixo.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animacaoAtual,
      child: dadosDevemSeUnir
          ? Spring.fadeOut(
              child: Image.asset(
                widget.dado,
                height: 100,
                width: 100,
              ),
            )
          : Spring.rotate(
              springController: widget.controladorSpring,
              alignment: Alignment.center,
              startAngle: 0,
              endAngle: rodarDados ? 720 : 0,
              animDuration: Duration(milliseconds: 300),
              animStatus: (AnimStatus status) {
                if (status == AnimStatus.completed) {
                  setState(() {
                    rodarDados = false;
                  });
                }
              },
              child: Image.asset(
                widget.dado,
                height: 100,
                width: 100,
              ),
            ),
    );
  }
}
