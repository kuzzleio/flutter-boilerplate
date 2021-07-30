import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/inherited/kuzzle_sdk.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_boilerplate/messages.i18n.dart';
import 'package:kuzzle/kuzzle.dart';

class Login extends StatefulWidget {
  const Login({Key? key, this.error}) : super(key: key);

  final String? error;

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _loggingIn = false;
  final _m = const Messages();
  String? _error;
  bool _showPassword = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _error = widget.error;
    const FlutterSecureStorage().read(key: 'rememberMe').then((value) {
      if (value != null) {
        setState(() {
          _rememberMe = true;
          _emailController.text = value;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 50, right: 50, bottom: 30),
                  child: Center(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_outlined),
                          labelText: _m.login.email,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return _m.login.emailValidator;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          labelText: _m.login.password,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return _m.login.passwordValidator;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text(_m.login.rememberMe),
                    ],
                  ),
                ),
                Opacity(
                  opacity: _error == null ? 0.0 : 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      _error ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _loggingIn ? Colors.grey : Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            _error = null;
                          });
                          if (_loggingIn == false) {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              setState(() {
                                _loggingIn = true;
                              });
                              try {
                                KuzzleSdk.of(context).kuzzle.jwt = null;
                                final res = await KuzzleSdk.of(context)
                                    .kuzzle
                                    .auth
                                    .login(
                                      'local',
                                      {
                                        'username': _emailController.text
                                            .trim()
                                            .toLowerCase(),
                                        'password': _passwordController.text,
                                      },
                                      expiresIn: '24h',
                                    );
                                const storage = FlutterSecureStorage();
                                await storage.write(
                                    key: 'kuzzleToken', value: res);
                                if (_rememberMe) {
                                  await storage.write(
                                    key: 'rememberMe',
                                    value: _emailController.text,
                                  );
                                }
                                Navigator.pushReplacementNamed(context, '/');
                              } catch (e) {
                                setState(() {
                                  _loggingIn = false;
                                  if ((e as KuzzleError).message != null) {
                                    _error = e.message![0].toUpperCase() +
                                        e.message!.substring(1);
                                  } else {
                                    _error = e.id;
                                  }
                                });
                              }
                            }
                          }
                        },
                        child: Text(
                          _m.login.loginButtonLabel,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
