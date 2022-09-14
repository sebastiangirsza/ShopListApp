import 'package:flutter/material.dart';
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
                          decoration: const BoxDecoration(color: Colors.grey),
                          child: Center(
                            child: Text(
                              storageNames[index],
                            ),
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
