import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ShopListApp/app/cubit/auth_cubit.dart';
import 'package:ShopListApp/app/home/home_page.dart';
import 'package:ShopListApp/app/login/login_page.dart';
import 'package:ShopListApp/app/repositories/firebase_auth_repository.dart';
import 'package:ShopListApp/data/remote_data_sources/user_remote_data_source.dart';

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
  int splashtime = 1;

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
                  const AnimatedSize(
                    curve: Curves.easeIn,
                    duration: Duration(seconds: 3),
                    child: CircleAvatar(
                      radius: 110,
                      backgroundColor: Color.fromARGB(255, 0, 63, 114),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/icon/app_icon.png'),
                        radius: 100,
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
