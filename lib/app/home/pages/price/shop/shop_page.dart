import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:injectable/injectable.dart';
import 'package:shoplistapp/app/home/pages/price/shop/cubit/shop_cubit.dart';

import 'package:shoplistapp/app/injection_container.dart';

@injectable
class ShopPage extends StatelessWidget {
  const ShopPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShopCubit>()..start(),
      child: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          final shopModels = state.shops;
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
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 200, 233, 255),
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 7.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
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
                title: Text(
                  'Lista sklepów',
                  style: GoogleFonts.getFont(
                    'Saira',
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 200, 233, 255),
                    shadows: <Shadow>[
                      const Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 7.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                actions: const [],
              ),
              body: ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  for (final shopModel in shopModels) ...[
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            boxShadow: const <BoxShadow>[
                              BoxShadow(color: Colors.black, blurRadius: 15)
                            ],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                  shopModel.downloadURL,
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
