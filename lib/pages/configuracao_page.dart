import 'package:appimcnew/model/configuracoes_model.dart';
import 'package:appimcnew/repository/configuracoes_repository.dart';
import 'package:appimcnew/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class ConfiguracaoPage extends StatefulWidget {
  const ConfiguracaoPage({super.key});

  @override
  State<ConfiguracaoPage> createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    configuracoesRepository = await ConfiguracoesRepository.load();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Configuração Hive")),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextLabel(texto: "Nome"),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(hintText: "Nome Usuario"),
                controller: nomeUsuarioController,
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextLabel(texto: "Altura (Ex:120 cm)"),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Altura"),
                controller: alturaController,
              )),
          TextButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                try {
                  configuracoesModel.altura =
                      double.parse(alturaController.text);
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("Meu App"),
                          content: const Text("Altura invalida"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"))
                          ],
                        );
                      });
                  return;
                }
                configuracoesModel.nomeUsuario = nomeUsuarioController.text;
                configuracoesRepository.salvar(configuracoesModel);
                Navigator.pop(context);
              },
              child: const Text("Salvar"))
        ],
      ),
    ));
  }
}
