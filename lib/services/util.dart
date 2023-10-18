import 'package:flutter/material.dart';

class Util {
  Color color = Colors.transparent;
  Icon icone = const Icon(Icons.task_alt_rounded);

  double calculaIMC(double peso, double altura) {
    return (peso / ((altura / 100) * (altura / 100)));
  }

  String classificarIMC(double imc) {
    switch (imc) {
      case < 16:
        {
          color = Colors.red;
          icone = const Icon(Icons.crisis_alert);
          return "${imc.toStringAsFixed(2)} - Magreza grave";
        }
      case >= 16 && < 17:
        {
          color = Colors.yellow;
          icone = const Icon(Icons.add_reaction_rounded);
          return "${imc.toStringAsFixed(2)} - Magreza moderada";
        }
      case >= 17 && < 18.5:
        {
          color = Colors.yellow;
          icone = const Icon(Icons.add_reaction_rounded);
          return "${imc.toStringAsFixed(2)} - Magreza leve";
        }
      case >= 18.5 && < 25:
        {
          color = Colors.green;
          icone = const Icon(Icons.task_alt_rounded);
          return "${imc.toStringAsFixed(2)} - Saudável";
        }
      case >= 25 && < 30:
        {
          color = Colors.yellow;
          icone = const Icon(Icons.add_reaction_rounded);
          return "${imc.toStringAsFixed(2)} - Sobrepeso";
        }
      case >= 30 && < 35:
        {
          color = Colors.yellow;
          icone = const Icon(Icons.add_reaction_rounded);
          return "${imc.toStringAsFixed(2)} - Obsidade Grau I";
        }
      case >= 35 && < 40:
        {
          color = Colors.red;
          icone = const Icon(Icons.crisis_alert);
          return "${imc.toStringAsFixed(2)} - Obsidade Grau II (severa)";
        }
      case >= 40:
        {
          color = Colors.red;
          icone = const Icon(Icons.crisis_alert);
          return "${imc.toStringAsFixed(2)} - Obsidade Grau III (mórbida)";
        }
      default:
        return "IMC inválido";
    }
  }
}
