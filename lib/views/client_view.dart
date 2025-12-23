import 'package:flutter/material.dart';
import 'package:megacell/controllers/calculadora_controller.dart';
import 'package:megacell/widgets/custom_titles.dart';

class ClientView extends StatefulWidget {
  final double precoFinal;
  final double parcX6;
  final double parcX12;

  const ClientView({
    super.key,
    required this.precoFinal,
    required this.parcX6,
    required this.parcX12,
  });

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  CalculadoraController _calc = CalculadoraController();
  double valorParcela6x = 0.0;
  double valorParcela12x = 0.0;

  void _calcularValoresParcelas() {
    setState(() {
      valorParcela12x = _calc.calcularValorParcela(
        valor: widget.parcX12,
        numParcelas: 12,
      );

      valorParcela6x = _calc.calcularValorParcela(
        valor: widget.parcX6,
        numParcelas: 6,
      );
    });
  }

  @override
  void initState() {
    _calcularValoresParcelas();
    super.initState();
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
            physics:
                NeverScrollableScrollPhysics(), // Desativa o scroll da lista (já que o pai já tem scroll)
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,

              children: [
                CustomTitles(
                  title: "Valor total",
                  value: widget.precoFinal,
                  titleSize: 20,
                  valueSize: 40,
                ),
                Divider(),
                CustomTitles(
                  title: "Parcelado em 6X",
                  value: widget.parcX6,
                  valueSize: 33,
                  titleSize: 18,
                ),
                CustomTitles(
                  title: "Valor das parcelas",
                  value: valorParcela6x,
                  valueSize: 23,
                  titleSize: 18,
                ),
                Divider(),
                CustomTitles(
                  title: "Parcelado em 12X",
                  value: widget.parcX12,
                  valueSize: 33,
                  titleSize: 18,
                ),
                CustomTitles(
                  title: "Valor das parcelas",
                  value: valorParcela12x,
                  valueSize: 23,
                  titleSize: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
