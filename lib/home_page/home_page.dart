import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo_app/home_page/cubit/home_page_cubit.dart';
import 'package:my_todo_app/main.dart';
import 'package:my_todo_app/widgets/add_position.dart';
import 'package:my_todo_app/widgets/update_position.dart';
import 'package:my_todo_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: Builder(builder: (context) {
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
                      });
                      context.read<HomePageCubit>().orderBy(_selectedItem);
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
                            updatePosition(context, document);
                          },
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
