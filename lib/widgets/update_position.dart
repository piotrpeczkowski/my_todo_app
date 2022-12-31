import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_app/home_page/cubit/home_page_cubit.dart';

Future<void> updatePosition(context, document) async {
  final title = TextEditingController();
  if (document != null) {
    title.text = document['title'];
  }
  return showModalBottomSheet(
    backgroundColor: const Color.fromARGB(255, 240, 240, 240),
    isScrollControlled: true,
    isDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25, top: 10),
                child: Text(
                  'Edytuj bieżące zadanie:',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              //TEXT FIELD - NAZWA ZADANIA
              Padding(
                padding: const EdgeInsets.only(bottom: 6, top: 10),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: ThemeData()
                          .colorScheme
                          .copyWith(primary: Colors.orange)),
                  child: TextField(
                    maxLength: 35,
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: InputDecoration(
                      label: Text(
                        'Edytuj treść treść',
                        style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.orange,
                      prefixIcon: const Icon(Icons.edit_note),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.orange,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    controller: title,
                  ),
                ),
              ),
              //PRZYCISK ZAKTUALIZUJ
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: BlocProvider(
                  create: (context) => HomePageCubit(),
                  child: BlocBuilder<HomePageCubit, HomePageState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.withOpacity(0.9),
                        ),
                        onPressed: () {
                          if (title.text != '') {
                            // FirebaseFirestore.instance
                            //     .collection('tasks')
                            //     .doc(document!.id)
                            //     .update({
                            //   "title": title.text,
                            // });
                            context.read<HomePageCubit>().updateTask(
                                  id: document!.id,
                                  title: title.text,
                                );
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Zaktualizuj',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      );
                    },
                  ),
                ),
              ),
              //PRZYCISK ANULUJ
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.withOpacity(0.9)),
                  child: Text(
                    'Anuluj',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
