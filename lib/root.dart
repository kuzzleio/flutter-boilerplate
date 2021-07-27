import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/home_page/home_page.dart';
import 'package:flutter_boilerplate/inherited/kuzzle_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/login/login.dart';
import 'package:flutter_boilerplate/splashscreen/splashscreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kuzzle/kuzzle.dart';

enum TokenState { initializing, expired, done }

class Root extends StatefulWidget {
  const Root({
    Key? key,
    this.updateUser,
  }) : super(key: key);

  final Function(KuzzleUser)? updateUser;

  @override
  _Root createState() => _Root();
}

class _Root extends State<Root> {
  TokenState tokenState = TokenState.initializing;
  String? _error;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final kuzzle = KuzzleSdk.of(context).kuzzle;
    try {
      await kuzzle.connect();
      kuzzle.on('error', (err) {
        print(err);
      });
      const storage = FlutterSecureStorage();
      final storedToken = await storage.read(key: 'kuzzleToken');

      if (storedToken == null) {
        setState(() {
          tokenState = TokenState.expired;
        });
      } else {
        final checkTokenResponse = await kuzzle.auth.checkToken(storedToken);
        if (checkTokenResponse['valid'] == true) {
          KuzzleSdk.of(context).kuzzle.jwt = storedToken;
          final currentUser = await kuzzle.auth.getCurrentUser();
          widget.updateUser?.call(currentUser);
          setState(() {
            tokenState = TokenState.done;
          });
        } else {
          await storage.delete(key: 'kuzzleToken');
          setState(() {
            tokenState = TokenState.expired;
          });
        }
      }
    } catch (err) {
      setState(() {
        if (err is SocketException) {
          _error = err.osError?.message ?? err.message;
          tokenState = TokenState.expired;
        } else {
          _error = (err as KuzzleError).message;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tokenState == TokenState.done) {
      return const HomePage();
    } else if (_error != null) {
      return Login(error: _error);
    } else if (tokenState == TokenState.expired) {
      return const Login();
    }
    return const Scaffold(
      body: Center(
        child: SplashScreen(),
      ),
    );
  }
}
