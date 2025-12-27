import 'package:flutter/foundation.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:printing/printing.dart' hide Printer;

class SmartPrinterController {
  final _thermalPrinter = FlutterThermalPrinter.instance;

  Future<bool> conectar(Printer printer) async {
    return await _thermalPrinter.connect(printer);
  }

  Future<void> imprimir(dynamic dispositivoSelecionado, String conteudo) async {
    if (kIsWeb) {
      await _imprimirWeb(conteudo);
    } else {
      await _imprimirNativo(dispositivoSelecionado);
    }
  }

  Future<void> _imprimirNativo(Printer printer) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile); // Fixo para LEON-560

    List<int> bytes = [];
    bytes += generator.text(
      'LEON-560 - RECIBO',
      styles: const PosStyles(bold: true),
    );
    bytes += generator.feed(2);
    bytes += generator.cut();

    await _thermalPrinter.connect(printer);
    await _thermalPrinter.printData(printer, bytes);
  }

  Future<void> _imprimirWeb(String texto) async {
    await Printing.layoutPdf(
      onLayout: (format) async => await Printing.convertHtml(
        format: format,
        html:
            '<html><body style="width: 58mm; font-family: monospace;">$texto</body></html>',
      ),
    );
  }
}
