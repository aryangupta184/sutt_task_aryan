import 'dart:convert';
import 'package:http/http.dart' as http;


class LanguageApi{

  static Future<List> getLanguage() async{

    var uri  = Uri.https('google-translate1.p.rapidapi.com','/language/translate/v2/languages',);

    final response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "9a81521204mshdcda43b1405500bp119aa6jsna2f657326ece",
      "X-RapidAPI-Host": "google-translate1.p.rapidapi.com",
    });

    Map data = jsonDecode(response.body);
    List _temp=[];

    for (var i in data['data']['languages']){
      _temp.add(i['language']);
    }

    return _temp;
  }
}

// const req = unirest('GET', 'https://google-translate1.p.rapidapi.com/language/translate/v2/languages');
//
// req.headers({
// 'Accept-Encoding': 'application/gzip',
// 'X-RapidAPI-Key': '4ae30d5cbcmsh34329362e798210p1a068bjsnfa1b96320b4f',
// 'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
// });

