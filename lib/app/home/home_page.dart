import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shoplistappsm/app/cubit/auth_cubit.dart';
import 'package:shoplistappsm/app/home/pages/recipes/recipes.dart';
import 'package:shoplistappsm/app/home/pages/shop_list/shop_list.dart';
import 'package:shoplistappsm/app/home/pages/your_products/your_products.dart';
import 'package:shoplistappsm/app/repositories/firebase_auth_repository.dart';
import 'package:shoplistappsm/data/remote_data_sources/user_remote_data_source.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(FirebaseAuthRespository(UserRemoteDataSource()))..start(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Container(
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
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                leading: IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'images/icon/app_icon_2.png'),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        'Shop List App',
                                        style: GoogleFonts.getFont('Saira',
                                            fontSize: 20),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'version 1.0.0',
                                        style: GoogleFonts.getFont('Saira',
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              content: ListView(
                                shrinkWrap: true,
                                children: [
                                  Text(
                                    'Aplikacja stworzona do łatwiejszego planowania robienia zakupów',
                                    style: GoogleFonts.getFont('Saira',
                                        fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Dięki tej aplikacji możesz sprawdzić jakich produktów potrzebujesz, dodać je do listy, a następnie po kupieniu ich dodać je do odpowiedniego miejsca przechowywania',
                                    style: GoogleFonts.getFont('Saira',
                                        fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cofnij')),
                              ],
                            )),
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                    )),
                title: Center(
                    child: Text(
                  'Shop List',
                  style: GoogleFonts.getFont('Saira',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                )),
                actions: [
                  IconButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Jesteś zalogowany jako: ',
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  '${state.user?.email}',
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cofnij')),
                                  const _SignOutButton(),
                                ],
                              )),
                      icon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ))
                ],
              ),
              body: Builder(builder: (context) {
                if (currentIndex == 0) {
                  return const ShopListPage();
                }
                if (currentIndex == 1) {
                  return const YourProductsPage();
                }
                if (currentIndex == 2) {
                  return const RecipesPage();
                }
                return Container();
              }),
              bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.white,
                selectedLabelStyle: GoogleFonts.getFont('Saira'),
                unselectedLabelStyle: GoogleFonts.getFont('Saira'),
                currentIndex: currentIndex,
                onTap: (newIndex) {
                  setState(() {
                    currentIndex = newIndex;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.edit_note_rounded),
                    label: 'Lista zakupów',
                    backgroundColor: Color.fromARGB(255, 100, 100, 100),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: 'Moje produkty',
                    backgroundColor: Color.fromARGB(255, 100, 100, 100),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dinner_dining),
                    label: 'Przepisy',
                    backgroundColor: Color.fromARGB(255, 100, 100, 100),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.liquor),
                    label: 'Inne',
                    backgroundColor: Color.fromARGB(255, 100, 100, 100),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(FirebaseAuthRespository(UserRemoteDataSource())),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().logOut();
                Navigator.of(context).pop();
              },
              child: const Text('Wyloguj'));
        },
      ),
    );
  }
}
