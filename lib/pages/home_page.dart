import 'package:appimcnew/model/configuracoes_model.dart';
import 'package:appimcnew/model/peso_model.dart';
import 'package:appimcnew/repository/configuracoes_repository.dart';
import 'package:appimcnew/repository/peso_repository.dart';
import 'package:appimcnew/services/util.dart';
import 'package:appimcnew/shared/widgets/custon_drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  final String titulo = "Calculadora de IMC";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _peso = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _altura = 0;
  String _nome = "";

  static PesoRepository pesoRepository = PesoRepository();
  int tamanhoDaLista = 0;
  List<PesoModel> listaDePeso = <PesoModel>[];

  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();

  final util = Util();
  @override
  void initState() {
    super.initState();
    carregarPeso();
    Future<List<PesoModel>> listaDeImc = pesoRepository.obterDados();
    listaDeImc.then((novaListaDeImc) {
      setState(() {
        this.listaDePeso = novaListaDeImc;
        tamanhoDaLista = novaListaDeImc.length;
      });
    });
  }

  void carregarPeso() async {
    configuracoesRepository = await ConfiguracoesRepository.load();
    configuracoesModel = configuracoesRepository.obterDados();
    _altura = configuracoesModel.altura;
    _nome = configuracoesModel.nomeUsuario;
    setState(() {});
  }

  _carregarLista() async {
    Future<List<PesoModel>> noteListFuture = pesoRepository.obterDados();
    noteListFuture.then((novaListaDeImc) {
      setState(() {
        listaDePeso = novaListaDeImc;
        tamanhoDaLista = novaListaDeImc.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      drawer: CustonDrawer(nomeUsuario: _nome),
      body: _listaDePeso(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _adicionarImc();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget campoDePeso() {
    return TextFormField(
      controller: _peso,
      keyboardType: TextInputType.number,
      validator: (valor) {
        if ((valor!.isEmpty) || (double.parse(_peso.text) == 0)) {
          return "Campo Obrigatório";
        }
      },
      decoration: const InputDecoration(
        hintText: 'peso (Ex:70.5 kg)',
        labelText: 'peso (Ex:70.5 kg)',
        border: OutlineInputBorder(),
      ),
    );
  }

  void _adicionarImc() {
    _peso.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Novo IMC"),
          content: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[campoDePeso()],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Salvar"),
              onPressed: () {
                PesoModel _pesoModel;
                if (_formKey.currentState!.validate()) {
                  ;
                  _pesoModel = PesoModel(0, double.parse(_peso.text),
                      DateFormat("dd/MM/yyyy").format(DateTime.now()));
                  pesoRepository.adicionar(_pesoModel);
                  _carregarLista();
                  _formKey.currentState!.reset();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _listaDePeso() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: tamanhoDaLista,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: ListTile(
            title: Text(util.classificarIMC(
                util.calculaIMC(listaDePeso[index].peso, _altura))),
            subtitle: Text(
                "Data Pesado: ${listaDePeso[index].datapesado}, Peso: ${listaDePeso[index].peso} kg"),
            leading: CircleAvatar(
              backgroundColor: util.color,
              child: util.icone,
            ),
          ),
        );
      },
    );
  }
}
