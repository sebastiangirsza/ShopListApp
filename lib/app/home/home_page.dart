import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistapp/app/cubit/auth_cubit.dart';
import 'package:shoplistapp/app/home/pages/recipes/recipes.dart';
import 'package:shoplistapp/app/home/pages/shop_list/shop_list_page.dart';
import 'package:shoplistapp/app/home/pages/your_products/pages/storage.dart';
import 'package:shoplistapp/app/repositories/firebase_auth_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

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
                  Color.fromARGB(255, 200, 233, 255),
                  Color.fromARGB(255, 213, 238, 255),
                  Color.fromARGB(255, 228, 244, 255),
                  Color.fromARGB(255, 244, 250, 255),
                ],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                elevation: 10,
                scrolledUnderElevation: 10,
                toolbarHeight: 60,
                backgroundColor: Colors.white,
                foregroundColor: Colors.white,
                leading: const InfoButtonWidget(),
                title: Center(
                    child: Text(
                  'Shop List',
                  style: GoogleFonts.getFont(
                    'Saira',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: const Color.fromARGB(255, 200, 233, 255),
                    shadows: <Shadow>[
                      const Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 7.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                )),
                actions: const [PersonButtonWidget()],
              ),
              body: Builder(builder: (context) {
                if (currentIndex == 0) {
                  return const ShopListPage();
                }
                if (currentIndex == 1) {
                  return const PurchasedProductsPage(
                    storageName: 'Lodówka',
                  );
                }
                if (currentIndex == 2) {
                  return const RecipesPage();
                }
                return Container();
              }),
              bottomNavigationBar: SizedBox(
                height: 60,
                child: BottomNavigationBar(
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.black,
                  selectedLabelStyle: GoogleFonts.getFont(
                    'Saira',
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: GoogleFonts.getFont('Saira'),
                  currentIndex: currentIndex,
                  onTap: (newIndex) {
                    setState(() {
                      currentIndex = newIndex;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.edit_note_rounded,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                      label: 'Lista zakupów',
                      backgroundColor: Color.fromARGB(255, 200, 233, 255),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                      label: 'Moje produkty',
                      backgroundColor: Color.fromARGB(255, 200, 233, 255),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.dinner_dining,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                      label: 'Przepisy',
                      backgroundColor: Color.fromARGB(255, 200, 233, 255),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.liquor,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                      label: 'Inne',
                      backgroundColor: Color.fromARGB(255, 200, 233, 255),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PersonButtonWidget extends StatelessWidget {
  const PersonButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(FirebaseAuthRespository(UserRemoteDataSource()))..start(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        title: Text(
                          'Jesteś zalogowany jako: ',
                          style: GoogleFonts.getFont('Saira',
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          '${state.user?.email}',
                          style: GoogleFonts.getFont('Saira',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cofnij',
                                style: GoogleFonts.getFont('Saira',
                                    fontSize: 13,
                                    color:
                                        const Color.fromARGB(255, 0, 63, 114),
                                    fontWeight: FontWeight.bold),
                              )),
                          const _SignOutButton(),
                        ],
                      )),
              icon: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 200, 233, 255),
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 4.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

class InfoButtonWidget extends StatelessWidget {
  const InfoButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('images/icon/app_icon_2.png'),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            'ShopListApp',
                            style: GoogleFonts.getFont('Saira',
                                fontSize: 20, color: Colors.black),
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
                                fontSize: 15, color: Colors.black),
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
                            fontSize: 12, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Dzięki tej aplikacji możesz sprawdzić jakich produktów potrzebujesz, dodać je do listy, a następnie po kupieniu ich dodać je do odpowiedniego miejsca przechowywania',
                        style: GoogleFonts.getFont('Saira',
                            fontSize: 10, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cofnij',
                          style: GoogleFonts.getFont('Saira',
                              fontSize: 12,
                              color: const Color.fromARGB(255, 0, 63, 114),
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )),
        icon: const Icon(
          Icons.info_outline_rounded,
          color: Color.fromARGB(255, 200, 233, 255),
          shadows: [
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 4.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ));
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 200, 233, 255),
              ),
              onPressed: () {
                context.read<AuthCubit>().logOut();
                Navigator.of(context).pop();
              },
              child: Text(
                'Wyloguj',
                style: GoogleFonts.getFont('Saira',
                    fontSize: 13,
                    color: const Color.fromARGB(255, 0, 63, 114),
                    fontWeight: FontWeight.bold),
              ));
        },
      ),
    );
  }
}
