import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.red, Colors.orange],
            ),
          ),
        ),
        title: Text(
          Strings.appTitle,
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'sort by datetime',
            onPressed: () {},
            icon: const Icon(Icons.sort_sharp),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
        tooltip: 'add TODO',
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.black87,
              Colors.black54,
            ],
          ),
        ),
        child: ListView(
          children: const [NoteWidget('Test title', "29.11.2022")],
        ),
      ),
    );
  }
}

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
