import 'package:bloc_flutter/data/model/character.dart';
import 'package:bloc_flutter/data/model/qoute.dart';
import 'package:bloc_flutter/data/repositories/characters_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'charcaters_state.dart';

class CharcatersCubit extends Cubit<CharcatersState> {
  CharcatersCubit() : super(CharcatersInitial()) {
    fetchCaractersData();
  }
  static CharcatersCubit get(context) => BlocProvider.of(context);
  List<Character> characters = [];
  List<Character> searchedCharacters = [];
  List<String> quots = [];
  bool isSearching = false;

  fetchCaractersData() {
    CharactersRepo.getAllCharacter().then((value) {
      emit(CharactersLoaded(value));
      characters = value;
    }).catchError((err) {
      emit(CharactersError(err));
    });
  }

  changeSearchingState() {
    isSearching = !isSearching;
    searchCharacters(text: '');
    emit(ChangeSearchState());
  }

  searchCharacters({required String text}) {
    emit(SearchLoading());
    searchedCharacters = characters
        .where((element) => element.name.toLowerCase().startsWith(text))
        .toList();
    emit(SearchDone(sCharacters: searchedCharacters));
  }

  getQuotesOfCharacter({required String charName}) {
    emit(QuoteLoading());
    quots = [];
    CharactersRepo.getCharQuote(charName: charName).then((value) {
      emit(QuoteLoaded(value));
      for (var element in value) {
        quots.add(element.qoute);
      }
    });
  }
}
