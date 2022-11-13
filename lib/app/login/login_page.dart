import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    widget.emailController.dispose();
    widget.passwordController.dispose();
    widget.confirmPasswordController.dispose();
    print('Dispose used');
    super.dispose();
  }

  var isCreatingAccount = false;

  String? errorMessage;
  String? notMatch;
  String? emailMessage;

  bool obscureText1 = true;
  bool obscureText2 = true;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp specialReg = RegExp(r'.*[@$#.*!%^&()€;:\?,/=+<>].*');
  RegExp email1Reg = RegExp(r'.*[@].*');
  RegExp email2Reg = RegExp(r'.*[.].*');

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
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                      color: Colors.black, blurRadius: 3, offset: Offset(3, 3))
                ],
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Text(
                      isCreatingAccount == true
                          ? 'Zarejestruj się'
                          : 'Zaloguj się',
                      style: GoogleFonts.getFont(
                        'Saira',
                        color: const Color.fromARGB(255, 0, 63, 114),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  loginAndPasswordTextField(
                      widget.emailController, 'E-mail', 'email'),
                  (emailMessage != null)
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 15, 0),
                          child: Text(
                            textAlign: TextAlign.center,
                            emailMessage!,
                            style: GoogleFonts.getFont(
                              'Saira',
                              fontSize: 8,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Container(height: 0),
                  loginAndPasswordTextField(
                      widget.passwordController, 'Hasło', 'password'),
                  (errorMessage != null)
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 15, 0),
                          child: Text(
                            textAlign: TextAlign.center,
                            errorMessage!,
                            style: GoogleFonts.getFont(
                              'Saira',
                              fontSize: 8,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : Container(height: 0),
                  (isCreatingAccount == true)
                      ? loginAndPasswordTextField(
                          widget.confirmPasswordController,
                          'Powtórz hasło',
                          'confirmPassword')
                      : Container(height: 0),
                  (notMatch == null)
                      ? Container(height: 0)
                      : Center(
                          child: Text(
                            notMatch!,
                            style: GoogleFonts.getFont('Saira',
                                fontSize: 8, color: Colors.red),
                          ),
                        ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 63, 114),
                        ),
                        onPressed: () async {
                          setState(() {
                            notMatch = null;
                            errorMessage = null;
                            emailMessage = null;
                          });

                          if (isCreatingAccount == true) {
                            try {
                              if (!email1Reg
                                      .hasMatch(widget.emailController.text) ||
                                  !email2Reg
                                      .hasMatch(widget.emailController.text)) {
                                setState(() {
                                  emailMessage = 'Nieprawidłowy format email';
                                });
                              } else {
                                setState(() {
                                  emailMessage = null;
                                });
                              }
                              if (widget.passwordController.text.length < 6 ||
                                  !numReg.hasMatch(
                                      widget.passwordController.text) ||
                                  !specialReg.hasMatch(
                                      widget.passwordController.text) ||
                                  !letterReg.hasMatch(
                                      widget.passwordController.text)) {
                                setState(() {
                                  errorMessage =
                                      'Hasło musi zawierać minimum 6 znaków, litery, cyfry oraz znaki spacjalne ( @\$#.*!%^&()€;:\\?,/=+<> )';
                                });
                              } else {
                                setState(() {
                                  errorMessage = null;
                                });
                              }
                              if (widget.passwordController.text !=
                                  widget.confirmPasswordController.text) {
                                setState(() {
                                  notMatch = 'Hasła są rózne';
                                });
                              } else {
                                setState(() {
                                  notMatch = null;
                                });
                              }

                              if (notMatch == null &&
                                  errorMessage == null &&
                                  emailMessage == null) {
                                context.read<AuthCubit>().createUser(
                                      email: widget.emailController.text,
                                      password: widget.passwordController.text,
                                    );
                                // dispose();
                              }
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
                              print(error.toString());
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
                              widget.passwordController.clear();
                              widget.confirmPasswordController.clear();
                              obscureText1 = true;
                              obscureText2 = true;
                            });
                          },
                          child: Text(
                            'Utwórz konto',
                            style: GoogleFonts.getFont(
                              'Saira',
                              color: const Color.fromARGB(255, 0, 63, 114),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      if (isCreatingAccount == true) ...[
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isCreatingAccount = false;
                              notMatch = null;
                              errorMessage = null;
                              widget.passwordController.clear();
                              widget.confirmPasswordController.clear();
                              emailMessage = null;
                              obscureText1 = true;
                              obscureText2 = true;
                            });
                          },
                          child: Text(
                            'Masz już konto?',
                            style: GoogleFonts.getFont(
                              'Saira',
                              color: const Color.fromARGB(255, 0, 63, 114),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginAndPasswordTextField(
      TextEditingController controller, String label, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 200, 233, 255),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black, blurRadius: 3, offset: Offset(3, 3))
          ],
        ),
        child: TextFormField(
          style: GoogleFonts.getFont(
            'Saira',
            fontSize: 12,
            color: Colors.black,
          ),
          obscureText: (title == 'email')
              ? false
              : (title == 'password')
                  ? obscureText1
                  : obscureText2,
          decoration: InputDecoration(
            suffixIcon: (title != 'email')
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye,
                        color: (title == 'password')
                            ? (obscureText1 == true)
                                ? Colors.black
                                : Colors.white
                            : (obscureText2 == true)
                                ? Colors.black
                                : Colors.white),
                    onPressed: () {
                      (title == 'password')
                          ? setState(() {
                              obscureText1 = !obscureText1;
                            })
                          : setState(() {
                              obscureText2 = !obscureText2;
                            });
                    },
                  )
                : null,
            border: InputBorder.none,
            labelStyle: GoogleFonts.getFont(
              'Saira',
              fontSize: 12,
              color: Colors.black,
            ),
            label: Text(
              label,
            ),
          ),
          controller: controller,
          onChanged: (title == 'password')
              ? (value) {
                  setState(() {
                    errorMessage = null;
                    notMatch = null;
                  });
                }
              : (title == 'confirmPassword')
                  ? ((value) {
                      setState(() {
                        notMatch = null;
                      });
                    })
                  : ((value) {
                      setState(() {
                        emailMessage = null;
                      });
                    }),
        ),
      ),
    );
  }
}
