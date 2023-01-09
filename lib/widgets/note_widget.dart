import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    required this.title,
    required this.datetime,
    required this.update,
    Key? key,
  }) : super(key: key);

  final String title;
  final String datetime;
  final Function update;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 228, 228, 228),
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
                  onPressed: () {
                    update();
                  },
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
