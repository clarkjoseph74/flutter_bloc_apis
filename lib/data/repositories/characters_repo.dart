import 'package:bloc_flutter/data/api/characters_api.dart';
import 'package:bloc_flutter/data/model/character.dart';
import 'package:bloc_flutter/data/model/qoute.dart';

class CharactersRepo {
  static Future<List<Character>> getAllCharacter() async {
    final List<dynamic> charactersList = await CharactersApi.getAllCharacters();
    return charactersList.map((char) => Character.fromMap(char)).toList();
  }

  static Future<List<Quote>> getCharQuote({required String charName}) async {
    final List<dynamic> quoteList =
        await CharactersApi.getCharQuote(charName: charName);
    return quoteList.map((quote) => Quote.fromMap(quote)).toList();
  }
}
