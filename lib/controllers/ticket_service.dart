import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

class TicketService {
  // Este método gera os bytes que a LEON-560 entende
  Future<List<int>> generate58mmTicket() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    List<int> bytes = [];

    bytes += generator.text(
      'LEON-560',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );
    bytes += generator.text(
      'Impressora de 58mm',
      styles: const PosStyles(align: PosAlign.center),
    );
    bytes += generator.hr();
    bytes += generator.text('ITEM 001 ........ R\$ 15,00');
    bytes += generator.feed(2);
    bytes += generator.cut();

    return bytes;
  }
}
