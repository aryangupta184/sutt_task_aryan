import 'dart:convert';
import 'package:dio/dio.dart';


import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;

class TranslationApi {



  static Future<List> translate(String message, String toLanguageCode) async {
    final dio = Dio();
    Response response;
    dio.options.headers["X-RapidAPI-Key"]="bb72b850f0msh562c04851d0f1a1p1a0ebcjsn813c727955e4";
    dio.options.headers["X-RapidAPI-Host"]="google-translate1.p.rapidapi.com";
    dio.options.headers["content-type"]="application/x-www-form-urlencoded";
    dio.options.headers['Accept-Encoding']='application/gzip';

    response = await dio.post(
      'https://google-translate1.p.rapidapi.com/language/translate/v2',
      data: {'q':message, 'target':toLanguageCode},
    );

    List convertandlang=[];

    //var uri = Uri.https('google-translate1.p.rapidapi.com','/language/translate/v2',);
    // final response = await http.post(
    //     uri,
    //     headers: <String, String>{
    //       "X-RapidAPI-Key": "4ae30d5cbcmsh34329362e798210p1a068bjsnfa1b96320b4f",
    //       "X-RapidAPI-Host": "google-translate1.p.rapidapi.com",
    //       "content-type": "application/x-www-form-urlencoded",
    //       'Accept-Encoding': 'application/gzip'
    //     },
    //     body: jsonEncode(<String, String>{
    //       'q':message,
    //       'target':toLanguageCode,
    //     })
    //     );

    if (response.statusCode == 200) {
      final body = response.data;
      final translations = body['data']['translations'] as List;
      final translation = translations.first;
      convertandlang.add(HtmlUnescape().convert(translation['translatedText']));
      convertandlang.add(HtmlUnescape().convert(translation['detectedSourceLanguage']));

      return convertandlang;
    } else if (response.statusCode == 403){
      print("API NOT AUTHORIZED");
      return convertandlang;

    } else if (response.statusCode == 502){
      print("ERROR FROM API");
      return convertandlang;

    }
    else {
      throw Exception();
    }
  }
}

//
//   const req = unirest('POST', 'https://google-translate1.p.rapidapi.com/language/translate/v2');
//
//   req.headers({
//   'content-type': 'application/x-www-form-urlencoded',
//   'Accept-Encoding': 'application/gzip',
//   'X-RapidAPI-Key': '4ae30d5cbcmsh34329362e798210p1a068bjsnfa1b96320b4f',
//   'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
// });
//
// req.form({
// q: 'Hello, world!',
// target: 'es'
// });