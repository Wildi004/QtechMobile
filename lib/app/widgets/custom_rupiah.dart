import 'package:intl/intl.dart';

class CurrencyHelper {
  static String formatRupiah(dynamic value) {
    if (value == null) return 'Rp 0';
    final number = double.tryParse(value.toString()) ?? 0;
    final format = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return format.format(number);
  }
}
