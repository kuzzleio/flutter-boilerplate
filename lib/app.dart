import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/config.dart';
import 'package:flutter_boilerplate/inherited/current_user.dart';
import 'package:flutter_boilerplate/inherited/kuzzle_sdk.dart';
import 'package:flutter_boilerplate/login/login.dart';
import 'package:flutter_boilerplate/root.dart';
import 'package:kuzzle/kuzzle.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String? token;
  Kuzzle? kuzzle;
  KuzzleUser? _currentUser;

  @override
  void initState() {
    super.initState();

    final proto = WebSocketProtocol(
      Uri(
        scheme: Config.scheme,
        host: Config.host,
        port: Config.port,
      ),
    );
    kuzzle = Kuzzle(proto);
  }

  @override
  Widget build(BuildContext context) => KuzzleSdk(
        kuzzle: kuzzle!,
        child: CurrentUser(
          user: _currentUser,
          child: MaterialApp(
            title: 'Kuzzle flutter boilerplate',
            initialRoute: '/',
            routes: {
              '/': (context) => Root(
                    updateUser: (user) {
                      setState(() {
                        _currentUser = user;
                      });
                    },
                  ),
              'login': (context) => Login(),
            },
          ),
        ),
      );
}
