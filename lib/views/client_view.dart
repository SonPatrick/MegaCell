import 'package:flutter/material.dart';
import 'package:megacell/controllers/calculadora_controller.dart';
import 'package:megacell/controllers/printer_controller.dart';
import 'package:megacell/controllers/ticket_service.dart';
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
  SmartPrinterController printer = SmartPrinterController();
  TicketService ticket = TicketService();
  dynamic _deviceSelected;

  final CalculadoraController _calc = CalculadoraController();
  TextEditingController tec = TextEditingController();

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
          actions: [
            IconButton(
              onPressed: () async {
                // 1. Gerar o conteúdo (Bytes para Nativo / Texto para Web)
                final bytes = await ticket.generate58mmTicket();
                const textoSimples = "RECIBO LEON-560\nTotal: R\$ 50,00";

                // 2. Chamar o controlador que decide a plataforma
                // Se estiver no Android, você precisa ter selecionado o '_deviceSelected' antes
                await printer.imprimir(_deviceSelected, textoSimples);
              },
              icon: Icon(Icons.print_outlined),
            ),
          ],
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
                TextFormField(
                  controller: tec, // <--- Faltou adicionar isso
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Digite o nome do produto ou serviço',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
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
