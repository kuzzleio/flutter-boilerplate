import 'package:flutter/material.dart';
import 'package:kuzzle/kuzzle.dart';

class CurrentUser extends InheritedWidget {
  final KuzzleUser? user;

  const CurrentUser(
    {
    Key? key,
    this.user,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CurrentUser oldWidget) => false;

  static CurrentUser of(BuildContext context) {
    final CurrentUser? result =
        context.dependOnInheritedWidgetOfExactType<CurrentUser>();
    return result!;
  }
}
