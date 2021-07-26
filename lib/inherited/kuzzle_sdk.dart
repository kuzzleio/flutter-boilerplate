import 'package:flutter/material.dart';
import 'package:kuzzle/kuzzle.dart';

class KuzzleSdk extends InheritedWidget {
  final Kuzzle kuzzle;

  const KuzzleSdk({
    Key? key,
    required this.kuzzle,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(KuzzleSdk oldWidget) => false;

  static KuzzleSdk of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<KuzzleSdk>()!;
}
