import 'package:intl/intl.dart';

String getCurrency(int money) {
  return NumberFormat.compactCurrency(symbol: "Ks: ").format(money);
}
