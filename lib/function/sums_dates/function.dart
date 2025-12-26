import 'package:app_eyewear/constants.dart';
import 'package:app_eyewear/view/layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:intl/intl.dart';

extension extrasToDouble on double {
  String toBRL() {
    String result = 'R\$ ';

    result += this.toStringAsFixed(2);
    result + result.replaceFirst('\.', '.');

    return result;
  }
}

extension TipoPagtoToString on TipoPagto {
  String get value => this.toString().split('.')[1];
}

TipoPagto stringToTipoPagto(String tipo) {
  return TipoPagto.values.firstWhere(
    (element) => element.value == tipo,
  );
}

extension extrasToTimestamp on Timestamp {
  String toFormat({format = 'dd/MM/yy HH:mm'}) {
    var formatter = DateFormat(format);

    return formatter.format(this.toDate());
  }
}

void snackBarInfo(String message) {
  Get.snackbar(
    'Info',
    message,
    backgroundColor: Colors.blue[900],
    margin: const EdgeInsets.all(20),
    dismissDirection: DismissDirection.horizontal,
    colorText: Layout.light(),
  );
}

void snackBarSucess(String message) {
  Get.snackbar(
    'Feito',
    message,
    backgroundColor: Colors.green,
    margin: const EdgeInsets.all(20),
    dismissDirection: DismissDirection.horizontal,
    colorText: Layout.light(),
  );
}

void snackBarDanger(String message) {
  Get.snackbar(
    'Ooops',
    message,
    backgroundColor: Colors.red,
    margin: const EdgeInsets.all(20),
    dismissDirection: DismissDirection.horizontal,
    colorText: Layout.light(),
  );
}
void snackBarWarning(String message) {
  Get.snackbar(
    'Atenção!',
    message,
    backgroundColor: Layout.secondaryHighLight(),
    margin: const EdgeInsets.all(20),
    dismissDirection: DismissDirection.horizontal,
    colorText: Layout.light(),
  );
}
