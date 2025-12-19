import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension extrasToDouble on double {
  String toBRL() {
    String result = 'R\$ ';

    result += this.toStringAsFixed(2);
    result + result.replaceFirst('\.', '.');

    
    return result;
  }
}

extension extrasToTimestamp on Timestamp {
  String toFormat({format = 'dd/MM/yy HH:mm'}) {
      var formatter = DateFormat(format);

      return formatter.format(this.toDate());
  }
}