import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_app/main.dart';
import 'package:my_todo_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedItem = 0;
  var _isDescending = true;
  var _order = 'timestamp';

  ordering() {
    if (_selectedItem == 0) {
      setState(() {
        _order = 'timestamp';
        _isDescending = true;
      });
    } else if (_selectedItem == 1) {
      setState(() {
        _order = 'timestamp';
        _isDescending = false;
      });
    } else if (_selectedItem == 2) {
      setState(() {
        _order = 'title';
        _isDescending = false;
      });
    } else {
      setState(() {
        _order = 'title';
        _isDescending = true;
      });
    }
  }

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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: PopupMenuButton(
                initialValue: _selectedItem,
                onSelected: (value) {
                  setState(() {
                    _selectedItem = value;
                    ordering();
                  });
                },
                child: const Text('SORTUJ'),
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      enabled: false,
                      child: Text(
                        'SORTUJ:',
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    PopupMenuItem(
                      value: 0,
                      child: Text(
                        'Od najnowszych',
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        'Od najstarszych',
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        'Alfabetycznie A-Z',
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text(
                        'Alfabetycznie Z-A',
                        style: GoogleFonts.lato(),
                      ),
                    ),
                  ];
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 140, 0),
        tooltip: 'add TODO',
        onPressed: () => ModalBottomSheetAdd.addPosition(context),
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
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .orderBy(_order, descending: _isDescending)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Coś poszło nie tak.. :C');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.white54,
                );
              }

              final documents = snapshot.data!.docs;

              return ListView(
                children: [
                  for (final document in documents) ...[
                    NoteWidget(document['title'], document['date'])
                  ],
                ],
              );
            }),
      ),
    );
  }
}
