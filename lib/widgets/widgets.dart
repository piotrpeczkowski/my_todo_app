import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget(
    this.title,
    this.datetime, {
    Key? key,
  }) : super(key: key);

  final String title;
  final String datetime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 196, 196, 196),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              datetime,
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black54),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ModalBottomSheetAdd {
  static void addPosition(context) {
    showModalBottomSheet(
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
                    'Dodaj nowe zadanie:',
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                //TEXT FIELD - NAZWA RESTAURACJI
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
                          'Dodaj treść',
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
                      controller: null,
                    ),
                  ),
                ),
                //PRZYCISK DODAJ
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.withOpacity(0.9),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Dodaj',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
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
}
