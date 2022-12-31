part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  // final List<TodoModel> results;
  final List<QueryDocumentSnapshot<Object?>> documents;
  final Timestamp timestamp;
  final bool isLoading;
  final String errorMessage;

  const HomePageState({
    required this.documents,
    required this.timestamp,
    required this.isLoading,
    required this.errorMessage,
  });
}
