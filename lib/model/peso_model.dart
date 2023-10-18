class PesoModel {
  int _id = 0;
  double _peso;
  String _datapesado;

  PesoModel(
    this._id,
    this._peso,
    this._datapesado,
  );

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get datapesado => _datapesado;

  set datapesado(String datapesado) {
    _datapesado = datapesado;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }
}
