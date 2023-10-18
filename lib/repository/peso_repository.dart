import 'package:appimcnew/database/database.dart';
import 'package:appimcnew/model/peso_model.dart';

class PesoRepository {
  Future<List<PesoModel>> obterDados() async {
    List<PesoModel> pesos = [];

    var db = await SQLiteDataBae().obterDataBase();

    var result = await db.rawQuery('SELECT id, peso, datahorapesado FROM imcs');

    for (var element in result) {
      pesos.add(PesoModel(
          int.parse(element["id"].toString()),
          double.parse(element["peso"].toString()),
          element["datahorapesado"].toString()));
    }
    return pesos;
  }

  Future<void> adicionar(PesoModel pesoModel) async {
    var db = await SQLiteDataBae().obterDataBase();
    await db.rawInsert('INSERT INTO imcs (peso, datahorapesado) values (?,?)',
        [pesoModel.peso, pesoModel.datapesado]);
  }

  Future<void> atualizar(PesoModel pesoModel) async {
    var db = await SQLiteDataBae().obterDataBase();
    await db.rawInsert(
        'UPDATE imcs SET peso = ?, datahorapesado=? WHERE id = ? ',
        [pesoModel.peso, pesoModel.datapesado, pesoModel.id]);
  }

  Future<void> remover(int id) async {
    var db = await SQLiteDataBae().obterDataBase();
    await db.rawInsert('DELETE FROM imcs WHERE id = ? ', [id]);
  }
}
