import 'package:cobras_e_escadas/constants/elementos_do_tabuleiro_constants.dart';
import 'package:cobras_e_escadas/dialogs/dialogo_evento_no_mapa.dart';
import 'package:cobras_e_escadas/dialogs/dialogo_fim_de_jogo.dart';
import 'package:cobras_e_escadas/dialogs/dialogo_vitoria.dart';
import 'package:mobx/mobx.dart';
part 'cobras_escadas.g.dart';

class CobrasEscadas = _CobrasEscadasBase with _$CobrasEscadas;

abstract class _CobrasEscadasBase with Store {
  final DialogoEventoNoMapa dialogoEventoNoMapa = DialogoEventoNoMapa();

  @observable
  bool _musicaTocando = true;
  @computed
  bool get musicaTocando => _musicaTocando;

  @observable
  bool _rolandoDados = false;
  @computed
  bool get rolandoDados => _rolandoDados;

  @observable
  bool _resultadoDisponivel = false;
  @computed
  bool get resultadoDisponivel => _resultadoDisponivel;

  @observable
  bool _turnoSendoComputado = true;
  @computed
  bool get turnoSendoComputado => _turnoSendoComputado;

  @observable
  int _posicaoJogadorUm = 1;
  @computed
  int get posicaoJogadorUm => _posicaoJogadorUm;

  @observable
  int _posicaoJogadorDois = 1;
  @computed
  int get posicaoJogadorDois => _posicaoJogadorDois;

  @observable
  int _jogadorAtual = 1;
  @computed
  int get jogadorAtual => _jogadorAtual;

  @observable
  int _valorDoDadoUm = 1;
  @computed
  int get valorDoDadoUm => _valorDoDadoUm;

  @observable
  int _valorDoDadoDois = 2;
  @computed
  int get valorDoDadoDois => _valorDoDadoDois;

  @action
  jogar(dadoUm, dadoDois, context) {
    _valorDoDadoUm = dadoUm;
    _valorDoDadoDois = dadoDois;

    if (_jogadorAtual == 1) {
      var total = _posicaoJogadorUm + dadoUm + dadoDois;

      if (total == 100) {
        DialogoVitoria.dialogoVitoria(context, _jogadorAtual);
      }

      _posicaoJogadorUm =
          total > 100 ? _posicaoJogadorUm - (total - 100) : total;

      var element = ElementosDoTabuleiroConstants.cobrasEscadas
          .where((element) => element['posicao'] == _posicaoJogadorUm);

      if (element.isNotEmpty) {
        dialogoEventoNoMapa.dialogEventoNoMapa(context, element, _jogadorAtual);
      }
    } else {
      var total = _posicaoJogadorDois + dadoUm + dadoDois;

      if (total == 100) {
        DialogoVitoria.dialogoVitoria(context, _jogadorAtual);
      }

      _posicaoJogadorDois =
          total > 100 ? _posicaoJogadorDois - (total - 100) : total;

      var element = ElementosDoTabuleiroConstants.cobrasEscadas
          .where((element) => element['posicao'] == _posicaoJogadorDois);

      if (element.isNotEmpty) {
        dialogoEventoNoMapa.dialogEventoNoMapa(context, element, _jogadorAtual);
      }
    }

    if (_posicaoJogadorUm == 100 || _posicaoJogadorDois == 100) {
      DialogoFimDeJogo.dialogoFimDeJogo(context);
    }

    if (dadoUm != dadoDois) {
      _jogadorAtual = _jogadorAtual == 1 ? 2 : 1;
    }
  }

  @action
  rolarDados() {
    _rolandoDados = !_rolandoDados;
  }

  @action
  mostrarResultado() {
    _resultadoDisponivel = !_resultadoDisponivel;
  }

  @action
  reiniciarPartida() {
    _posicaoJogadorUm = 1;
    _posicaoJogadorDois = 1;
  }

  @action
  moverJogador(player, value) {
    player == 1 ? _posicaoJogadorUm = value : _posicaoJogadorDois = value;
  }

  @action
  prontoParaUmaJogada({bool delay}) async {
    if (delay) {
      await Future.delayed(Duration(milliseconds: 6300));
    }

    _turnoSendoComputado = !_turnoSendoComputado;
  }

  @action
  desligarMusica() async {
    _musicaTocando = !_musicaTocando;
  }
}
