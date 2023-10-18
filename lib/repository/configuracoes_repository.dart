import 'package:appimcnew/model/configuracoes_model.dart';
import 'package:hive/hive.dart';

class ConfiguracoesRepository {
  static late Box box;

  static Future<ConfiguracoesRepository> load() async {
    if (Hive.isBoxOpen('configuracoes')) {
      box = Hive.box('configuracoes');
    } else {
      box = await Hive.openBox('configuracoes');
    }
    return ConfiguracoesRepository._criar();
  }

  ConfiguracoesRepository._criar();

  void salvar(ConfiguracoesModel configuracoesModel) {
    box.put('configuracoesModel', {
      'nomeUsuario': configuracoesModel.nomeUsuario,
      'altura': configuracoesModel.altura
    });
  }

  ConfiguracoesModel obterDados() {
    var configuracoes = box.get('configuracoesModel');
    if (configuracoes == null) {
      return ConfiguracoesModel.vazio();
    } else {
      return ConfiguracoesModel(
          configuracoes["nomeUsuario"], configuracoes["altura"]);
    }
  }
}
