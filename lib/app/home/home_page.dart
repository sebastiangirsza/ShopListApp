import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:shoplistapp/app/cubit/auth_cubit.dart';

import 'package:shoplistapp/app/home/pages/price/price_page.dart';
import 'package:shoplistapp/app/home/pages/recipes/recipes.dart';
import 'package:shoplistapp/app/home/pages/shop_list/shop_list_page.dart';
import 'package:shoplistapp/app/home/pages/your_products/purchased_products/purchased_products.dart';
import 'package:shoplistapp/app/injection_container.dart';

@injectable
class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..start(),
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
                return const PricePage();
              }),
              bottomNavigationBar: MotionTabBar(
                initialSelectedTab: 'Ceny produktów',
                labels: const [
                  'Lista zakupów',
                  'Moje produkty',
                  'Przepisy',
                  'Ceny produktów',
                ],
                icons: const [
                  Icons.edit_note_rounded,
                  Icons.shopping_bag_outlined,
                  Icons.dinner_dining,
                  Icons.price_change_outlined,
                ],
                onTabItemSelected: (newIndex) {
                  setState(() {
                    currentIndex = newIndex;
                  });
                },
                tabSize: 35,
                tabBarHeight: 45,
                textStyle: GoogleFonts.getFont(
                  color: Colors.black,
                  'Saira',
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                ),
                tabSelectedColor: Colors.black,
                tabIconColor: Colors.black,
                tabBarColor: const Color.fromARGB(255, 200, 233, 255),
              ),
            ),
          );
        },
      ),
    );
  }
}

@injectable
class PersonButtonWidget extends StatelessWidget {
  const PersonButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..start(),
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
                          const SignOutButton(),
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

@injectable
class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
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
