import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/home_page/cubit/home_page_cubit.dart';
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

  Future<void> updatePosition([DocumentSnapshot? document]) async {
    final title = TextEditingController();
    if (document != null) {
      title.text = document['title'];
    }
    await showModalBottomSheet(
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
                                    title.text,
                                    document!.id,
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

  Future<void> addPosition(context) async {
    final timestamp = Timestamp.now();
    final date = DateFormat('dd.MM.yyyy').format(DateTime.now());
    final title = TextEditingController();
    var isChanged = false;
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
                      controller: title,
                      onChanged: (newValue) {
                        isChanged = true;
                      },
                    ),
                  ),
                ),
                //PRZYCISK DODAJ
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
                          onPressed: isChanged == false
                              ? null
                              : () {
                                  context.read<HomePageCubit>().addTask(
                                        title.text,
                                        timestamp,
                                        date,
                                      );
                                  Navigator.of(context).pop();
                                },
                          child: Text('Dodaj',
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
        onPressed: () => addPosition(context),
        child: const Icon(Icons.add),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: BlocProvider(
          create: (context) => HomePageCubit()..start(),
          child: BlocBuilder<HomePageCubit, HomePageState>(
            builder: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                return const Center(child: Text('Coś poszło nie tak.. :C'));
              }
              if (state.isLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white54,
                  ),
                );
              }
              if (state.documents.isEmpty) {
                return Center(
                  child: Text(
                    'Brak wpisów do wyświetlenia',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              final documents = state.documents;
              return ListView(
                children: [
                  for (final document in documents) ...[
                    Dismissible(
                      key: ValueKey(document.id),
                      background: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 255, 92, 81),
                            ),
                            Text(
                              'Usuń',
                              style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      const Color.fromARGB(255, 255, 92, 81)),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (_) {
                        context.read<HomePageCubit>().deleteTask(document.id);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Pozycja usunięta'),
                          duration: Duration(seconds: 1),
                        ));
                      },
                      child: NoteWidget(
                        title: document['title'],
                        datetime: document['date'],
                        update: () {
                          updatePosition(document);
                        },
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
