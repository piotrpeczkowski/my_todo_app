import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(
          const HomePageState(
            documents: [],
            isLoading: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> deleteTask(String id) async {
    FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }

  Future<void> updateTask(
    String id,
    String title,
  ) async {
    FirebaseFirestore.instance.collection('tasks').doc(id).update({
      "title": title,
    });
  }

  Future<void> addTask(
    String title,
    Timestamp timestamp,
    String date,
  ) async {
    FirebaseFirestore.instance.collection('tasks').add({
      'title': title,
      'timestamp': timestamp,
      'date': date,
    });
  }

  Future<void> start() async {
    emit(
      const HomePageState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((data) {
      emit(
        HomePageState(
          documents: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          HomePageState(
            documents: const [],
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
