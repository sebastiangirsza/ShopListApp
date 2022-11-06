import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromARGB(255, 200, 233, 255),
            Color.fromARGB(255, 213, 238, 255),
            Color.fromARGB(255, 228, 244, 255),
            Color.fromARGB(255, 244, 250, 255),
          ],
        ),
      ),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isCreatingAccount == true
                    ? 'Zarejestruj się'
                    : 'Zaloguj się'),
                TextField(
                  controller: widget.emailController,
                ),
                TextField(
                  controller: widget.passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (isCreatingAccount == true) {
                      try {
                        context.read<AuthCubit>().createUser(
                              email: widget.emailController.text,
                              password: widget.passwordController.text,
                            );
                      } catch (error) {
                        const Text('ERROR');
                      }
                    } else {
                      try {
                        context.read<AuthCubit>().logIn(
                              email: widget.emailController.text,
                              password: widget.passwordController.text,
                            );
                      } catch (error) {
                        const Text('ERROR');
                      }
                    }
                  },
                  child: Text(isCreatingAccount == true
                      ? 'Utwórz konto'
                      : 'Zaloguj się'),
                ),
                if (isCreatingAccount == false) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isCreatingAccount = true;
                      });
                    },
                    child: const Text('Utwórz konto'),
                  ),
                ],
                if (isCreatingAccount == true) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isCreatingAccount = false;
                      });
                    },
                    child: const Text('Masz już konto?'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
