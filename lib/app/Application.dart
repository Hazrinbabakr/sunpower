import 'package:flutter/material.dart';
class Application extends StatefulWidget {
  final Widget child;

  Application({@required this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_ApplicationState>().restartApp();
  }

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
