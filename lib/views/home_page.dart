import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:megacell/controllers/calculadora_controller.dart';
import 'package:megacell/views/client_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController tec = TextEditingController();
  final CalculadoraController _calc = CalculadoraController();

  double luc = 0.0;
  double parcelamentoX6 = 0.0;
  double parcelamentoX12 = 0.0;

  void _calcular() {
    double? valorConvertido = double.tryParse(tec.text);

    if (valorConvertido != null) {
      double resultadoLuc = _calc.calcularLucratividade(valor: valorConvertido);

      setState(() {
        luc = resultadoLuc; // Atualiza a variável luc da classe
        parcelamentoX6 = _calc.calcularParcelamento6x(lucratividade: luc);
        parcelamentoX12 = _calc.calcularParcelamento12x(lucratividade: luc);
      });
    } else {
      luc = 0.0;
      log("Por favor, insira um número válido");
    }
  }

  void _exibir() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientView(
          precoFinal: luc,
          parcX6: parcelamentoX6,
          parcX12: parcelamentoX12,
        ),
      ),
    );
  }

  @override
  void initState() {
    tec.addListener(_calcular);
    super.initState();
  }

  @override
  void dispose() {
    tec.removeListener(_calcular);
    tec.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "MegaCell",
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1.2,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,

              children: [
                TextFormField(
                  controller: tec, // <--- Faltou adicionar isso
                  textInputAction: TextInputAction.done,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Digite o valor base',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),

                Text("luc = R\$ ${luc.toStringAsFixed(2)}"),
                Text(
                  "valor em 12x = R\$ ${parcelamentoX12.toStringAsFixed(2)}",
                ),
                Text("valor em 6x = R\$ ${parcelamentoX6.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Toque aqui para abrir a janela para o cliente",
          onPressed: _exibir,
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          child: Icon(Icons.calculate_outlined),
        ),
      ),
    );
  }
}
