import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplistapp/app/cubit/auth_cubit.dart';
import 'package:shoplistapp/app/home/home_page.dart';
import 'package:shoplistapp/app/login/login_page.dart';
import 'package:shoplistapp/app/repositories/firebase_auth_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

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
        scaffoldBackgroundColor: Colors.transparent,
        canvasColor: const Color.fromARGB(255, 2, 116, 209),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  int splashtime = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const RootPage();
      }));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Color.fromARGB(255, 40, 40, 40),
                  Color.fromARGB(255, 60, 60, 60),
                  Color.fromARGB(255, 80, 80, 80),
                  Color.fromARGB(255, 100, 100, 100),
                ],
              ),
            ),
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ClipOval(
                      child: AnimatedSize(
                        // clipBehavior: Clip.antiAlias,
                        curve: Curves.decelerate,
                        duration: const Duration(seconds: 1),
                        child: ClipOval(
                            child: Image.asset('images/icon/app_icon_2.png')),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: const Text(
                      'Shop List App',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('by Sebastian Girsza',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                            SizedBox(height: 15),
                            Text('version 1.0.0'),
                          ],
                        )
                      ],
                    ),
                  ),
                ])));
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(FirebaseAuthRespository(UserRemoteDataSource()))..start(),
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
