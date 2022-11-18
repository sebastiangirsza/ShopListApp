import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shoplistapp/app/home/pages/calendar/addShopping/cubit/add_cubit.dart';
import 'package:shoplistapp/app/repositories/items_repository.dart';
import 'package:shoplistapp/data/remote_data_sources/items_remote_data_source.dart';
import 'package:shoplistapp/data/remote_data_sources/user_remote_data_source.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // String? _imageURL;
  // String? _title;
  DateTime? _releaseDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCubit(
          ItemsRepository(ItemsRemoteDataSource(), UserRemoteDataSource())),
      child: BlocListener<AddCubit, AddState>(
        listener: (context, state) {
          if (state.saved) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddCubit, AddState>(
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
                    'Zaplanuj wyjazd do sklepu',
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
                body: _AddPageBody(
                  onTitleChanged: (newValue) {
                    setState(() {
                      // _title = newValue;
                    });
                  },
                  onImageUrlChanged: (newValue) {
                    setState(() {
                      // _imageURL = newValue;
                    });
                  },
                  onDateChanged: (newValue) {
                    setState(() {
                      _releaseDate = newValue;
                    });
                  },
                  selectedDateFormatted: _releaseDate == null
                      ? null
                      : DateFormat.yMMMEd().format(_releaseDate!),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddPageBody extends StatelessWidget {
  const _AddPageBody({
    Key? key,
    required this.onTitleChanged,
    required this.onImageUrlChanged,
    required this.onDateChanged,
    this.selectedDateFormatted,
  }) : super(key: key);

  final Function(String) onTitleChanged;
  final Function(String) onImageUrlChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      children: [
        textField(text: 'Nazwa sklepu'),
        const SizedBox(height: 20),
        textField(text: 'Godzina'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                const Duration(days: 365 * 10),
              ),
            );
            onDateChanged(selectedDate);
          },
          child: Text(selectedDateFormatted ?? 'Choose release date'),
        ),
      ],
    );
  }

  Widget textField({text}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white.withOpacity(0.5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: TextField(
        style: GoogleFonts.getFont('Saira', fontSize: 12, color: Colors.black),
        onChanged: onTitleChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelStyle: GoogleFonts.getFont(
            'Saira',
            fontSize: 12,
            color: Colors.black,
          ),
          label: Text(
            text,
          ),
        ),
      ),
    );
  }
}
