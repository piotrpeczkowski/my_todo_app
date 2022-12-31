import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
      : super(
          HomePageState(
            documents: const [],
            timestamp: Timestamp.now(),
            isLoading: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> deleteTask(String id) async {
    FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }

  Future<void> updateTask({
    required String title,
    required String id,
  }) async {
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

  Future<void> orderBy(int selectedItem) async {
    if (selectedItem == 0) {
      start(true, 'timestamp');
    } else if (selectedItem == 1) {
      start(false, 'timestamp');
    } else if (selectedItem == 2) {
      start(false, 'title');
    } else {
      start(true, 'title');
    }
  }

  Future<void> start(
    bool isDescending,
    String orderBy,
  ) async {
    emit(
      HomePageState(
        documents: const [],
        timestamp: Timestamp.now(),
        isLoading: true,
        errorMessage: '',
      ),
    );

    _streamSubscription?.cancel();
    _streamSubscription = FirebaseFirestore.instance
        .collection('tasks')
        .orderBy(orderBy, descending: isDescending)
        .snapshots()
        .listen((data) {
      emit(
        HomePageState(
          documents: data.docs,
          timestamp: Timestamp.now(),
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          HomePageState(
            documents: const [],
            timestamp: Timestamp.now(),
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
