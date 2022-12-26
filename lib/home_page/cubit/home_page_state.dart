part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  final List<QueryDocumentSnapshot<Object?>> documents;
  final bool isLoading;
  final String errorMessage;

  const HomePageState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}
