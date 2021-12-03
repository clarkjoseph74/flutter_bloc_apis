part of 'charcaters_cubit.dart';

@immutable
abstract class CharcatersState {}

class CharcatersInitial extends CharcatersState {}

class CharactersLoaded extends CharcatersState {
  final List<Character> characters;
  CharactersLoaded(this.characters);
}

class CharactersError extends CharcatersState {
  final String error;
  CharactersError(this.error);
}

class SearchLoading extends CharcatersState {}

class SearchDone extends CharcatersState {
  final List<Character> sCharacters;
  SearchDone({
    required this.sCharacters,
  });
}

class ChangeSearchState extends CharcatersState {}

class QuoteLoading extends CharcatersState {}

class QuoteLoaded extends CharcatersState {
  final List<Quote> qoutes;

  QuoteLoaded(this.qoutes);
}
