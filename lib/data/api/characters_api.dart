import 'package:bloc_flutter/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersApi {
  static late Dio dio;

  static init() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  static Future<List<dynamic>> getAllCharacters() async {
    try {
      final characters = await dio.get(charactersEndPoint);

      return characters.data;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }

  static Future<List<dynamic>> getCharQuote({required String charName}) async {
    try {
      final quotes =
          await dio.get(characterQuote, queryParameters: {'author': charName});
      return quotes.data;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }
}
