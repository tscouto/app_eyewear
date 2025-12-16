
import 'package:flutter/widgets.dart';


class TesteController extends InheritedWidget {

  final int id;
  final String name;

  TesteController({Key? key, required this.id, required this.name, required this.child}) : super(key: key, child: child);

  final Widget child;

  static TesteController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TesteController>();
  }

  @override
  bool updateShouldNotify(TesteController oldWidget) {
    return  (id != oldWidget.id && name != oldWidget.name) ; 
  }
}