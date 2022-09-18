import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoplistappsm/app/home/pages/your_products/pages/storage.dart';

class YourProductsPage extends StatelessWidget {
  const YourProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storageNames = [
      'Lodówka',
      'Zamrażarka',
      'Szafka kuchenna',
      'Chemia',
      'Inne',
    ];
    final routes = [
      const StoragePage(storageName: 'Lodówka'),
      const StoragePage(storageName: 'Zamrażarka'),
      const StoragePage(storageName: 'Szafka kuchenna'),
      const StoragePage(storageName: 'Chemia'),
      const StoragePage(storageName: 'Inne'),
    ];
    final icon = [
      Icons.kitchen_outlined,
      Icons.ac_unit_rounded,
      Icons.door_sliding_outlined,
      Icons.local_laundry_service_outlined,
      Icons.more_horiz_outlined,
    ];
    return Scaffold(
        body: ListView.builder(
            itemCount: storageNames.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 65,
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (_) => routes[index]));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: Colors.black, blurRadius: 15)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  style: GoogleFonts.getFont('Saira',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  storageNames[index]),
                              Icon(icon[index]),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
