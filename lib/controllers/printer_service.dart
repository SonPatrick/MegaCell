import 'dart:async';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter_thermal_printer/utils/printer.dart'
    show ConnectionType, Printer;

class PrinterService {
  final _printerManager = FlutterThermalPrinter.instance;
  StreamSubscription<List<Printer>>? _devicesStreamSubscription;
  List<Printer> devices = [];

  // 1. Buscar impressoras (Bluetooth no Android, USB no Windows)
  void startScan() async {
    _devicesStreamSubscription?.cancel();
    await _printerManager.getPrinters(
      connectionTypes: [ConnectionType.USB, ConnectionType.BLE],
    );
    _devicesStreamSubscription = _printerManager.devicesStream.listen((
      List<Printer> event,
    ) {
      devices = event;
      devices.removeWhere(
        (element) =>
            element.name == null ||
            element.name == '' ||
            element.name!.toLowerCase().contains("print") == false,
      );
    });
  }

  // 2. Imprimir na LEON-560 (58mm)
  Future<void> printReceipt(Printer printer) async {
    // Gerar os bytes usando o esc_pos_utils_plus (que é estável)
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);

    List<int> bytes = [];
    bytes += generator.text(
      'LEON-560',
      styles: const PosStyles(bold: true, align: PosAlign.center),
    );

    bytes += generator.text(
      'Venda Online',
      styles: const PosStyles(align: PosAlign.center),
    );

    bytes += generator.hr();
    bytes += generator.feed(2);
    bytes += generator.cut();

    // Enviar via flutter_thermal_printer
    await _printerManager.connect(printer);
    await _printerManager.printData(printer, bytes);
    await _printerManager.disconnect(printer);
  }
}
