import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/cubit/auth_cubit.dart';
import 'package:shoplistapp/app/cubit/verification_cubit.dart';
import 'package:shoplistapp/app/home/home_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    isEmailVerified = context.read<AuthCubit>().isEmailVerified();

    if (!isEmailVerified) {
      context.read<VerificationCubit>().sendVerificationEmail();

      setState(() {
        canResendEmail = true;
      });
      context.read<AuthCubit>().checkEmailVerified(isEmailVerified);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Container(
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                          offset: Offset(3, 3))
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont('Saira',
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        'Na podany adres e-mail został\nwysłany link aktywacyjny.\nWejdź w niego aby kontynuować.',
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 63, 114)),
                        onPressed: () {
                          context
                              .read<VerificationCubit>()
                              .sendVerificationEmail();
                        },
                        icon: const Icon(Icons.email, size: 32),
                        label: Text(
                          'Wyślij email z linkiem aktywacyjnym ponownie',
                          style: GoogleFonts.getFont('Saira',
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthCubit>().logOut();
                        },
                        child: Text(
                          'Anuluj',
                          style: GoogleFonts.getFont('Saira',
                              fontSize: 10,
                              color: const Color.fromARGB(255, 0, 63, 114),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
}
