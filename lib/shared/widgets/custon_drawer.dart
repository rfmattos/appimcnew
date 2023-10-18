import 'package:appimcnew/pages/configuracao_page.dart';
import 'package:flutter/material.dart';

class CustonDrawer extends StatelessWidget {
  final String nomeUsuario;
  const CustonDrawer({super.key, required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                context: context,
                builder: (BuildContext bc) {
                  return Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Text("Camera"),
                        leading: Icon(Icons.camera),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Text("Galeria"),
                        leading: Icon(Icons.album),
                      )
                    ],
                  );
                });
          },
          child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.cyan),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(
                      "https://play-lh.googleusercontent.com/ouL1lfSP_CyUgb5OUvI51jG3cevMfulA1GZGtS63r3Xfa8STYiIxq6KiY3PkMc6PcTk=w480-h960-rw")),
              accountName: Text("Calculadora de IMC"),
              accountEmail: Text(nomeUsuario)),
        ),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Dados Cadastrais")
                ],
              )),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConfiguracaoPage()));
          },
        ),
        const Divider(),
        const SizedBox(height: 1),
        InkWell(
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              child: const Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Sair")
                ],
              )),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    alignment: Alignment.centerLeft,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: const Text(
                      "Meu APP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Wrap(
                      children: [
                        Text("Deseja Sair?"),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Não")),
                      TextButton(
                          onPressed: () {
//                            Navigator.pushReplacement(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text("Sim"))
                    ],
                  );
                });
          },
        ),
      ],
    ));
  }
}
