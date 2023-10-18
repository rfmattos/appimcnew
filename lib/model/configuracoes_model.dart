class ConfiguracoesModel {
  String _nomeUsuario = "";
  double _altura = 0;

  ConfiguracoesModel.vazio() {
    _nomeUsuario = "";
    _altura = 0;
  }

  ConfiguracoesModel(this._nomeUsuario, this._altura);

  String get nomeUsuario => _nomeUsuario;
  set nomeUsuario(String nomeUsuario) {
    _nomeUsuario = nomeUsuario;
  }

  double get altura => _altura;
  set altura(double altura) {
    _altura = altura;
  }
}
