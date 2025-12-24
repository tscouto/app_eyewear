
import 'package:flutter/widgets.dart';


class TesteController extends InheritedWidget {

  final int id;
  final String name;

  const TesteController({super.key, required this.id, required this.name, required this.child}) : super(child: child);

  @override
  // ignore: overridden_fields
  final Widget child;

  static TesteController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TesteController>();
  }

  @override
  bool updateShouldNotify(TesteController oldWidget) {
    return  (id != oldWidget.id && name != oldWidget.name) ; 
  }
}