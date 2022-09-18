import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shoplistappsm/app/cubit/auth_cubit.dart';
import 'package:shoplistappsm/app/home/pages/recipes/recipes.dart';
import 'package:shoplistappsm/app/home/pages/shop_list/shop_list.dart';
import 'package:shoplistappsm/app/home/pages/your_products/your_products.dart';
import 'package:shoplistappsm/app/repositories/firebase_auth_repository.dart';

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
      create: (context) => AuthCubit(FirebaseAuthRespository())..start(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline_rounded)),
              title: Center(
                  child: Text(
                'Shop List',
                style: GoogleFonts.getFont('Saira',
                    fontWeight: FontWeight.bold, fontSize: 25),
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
                    icon: const Icon(Icons.person))
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
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
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
                    backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: 'Moje produkty',
                    backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dinner_dining),
                    label: 'Przepisy',
                    backgroundColor: Colors.blue,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.liquor),
                    label: 'Inne',
                    backgroundColor: Colors.blue,
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
      create: (context) => AuthCubit(FirebaseAuthRespository()),
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
