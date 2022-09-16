import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistappsm/app/cubit/auth_cubit.dart';
import 'package:shoplistappsm/app/home/home_page.dart';
import 'package:shoplistappsm/app/login/login_page.dart';
import 'package:shoplistappsm/app/repositories/firebase_auth_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop List',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.green[700],
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(FirebaseAuthRespository())..start(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return LoginPage();
          }
          return const HomePage();
        },
      ),
    );
  }
}
