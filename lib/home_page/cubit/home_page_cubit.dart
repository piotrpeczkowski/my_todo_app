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

  Future<void> orderBy(int _selectedItem) async {
    if (_selectedItem == 0) {
      start(true, 'timestamp');
    } else if (_selectedItem == 1) {
      start(false, 'timestamp');
    } else if (_selectedItem == 2) {
      //_order = 'title';
      // _isDescending = false;
    } else {
      // _order = 'title';
      // _isDescending = true;
    }
  }

  Future<void> start(
    bool isDescending,
    String orderBy,
  ) async {
    emit(
      const HomePageState(
        documents: [],
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
