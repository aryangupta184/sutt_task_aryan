import 'package:flutter/material.dart';
import 'package:sutt_task_aryan/models/languages.api.dart';
import 'package:sutt_task_aryan/models/translate.api.dart';
import 'package:sutt_task_aryan/router/route_utils.dart';
import 'package:sutt_task_aryan/views/signin_page.dart';
import 'package:go_router/go_router.dart';
import 'package:sutt_task_aryan/views/login_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<dynamic>? _languages;
  List<dynamic>? _convertandlang;

  String? username = SignInPage.sendusername.toString();

  Future<void> getLanguages() async {
    _languages = await LanguageApi.getLanguage();
    setState(() {});
  }

  Future<void> getTranslated(message, toLanguageCode) async {
    _convertandlang = await TranslationApi.translate(message, toLanguageCode);
    setState(() {});
  }

  String? selectedValue;
  String translatedtext='Call APIs';
  String detectedlang = 'Call APIs';

  TextEditingController _TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: Icon(Icons.account_circle_rounded),
          backgroundColor: Colors.grey[900],
          title: Text(
            username!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
                width: 100,
                child: TextButton(
                  onPressed: () {
                    FirebaseServices().signOut();
                    GoRouter.of(context).push(APP_PAGE.home.toPath);
                  },
                  child: const Text(
                    "Log out",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )),
          ],
        ),
        body: SafeArea(
          child: Center(
              child: Column(children: [
            const SizedBox(height: 30),
            const Icon(
              Icons.g_translate,
              size: 100,
            ),
            const SizedBox(height: 30),

                Container(

                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      getLanguages();
                    },
                    child: Text(
                      "CALL LANGUAGE CODE API",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.grey.shade900;
                          }
                          return Colors.black;
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
                  ),
                ),

                const SizedBox(height: 20),
                DropdownButton(
                  hint: new Text("Select Language Code"),
                  value: selectedValue,
                  onChanged: (v) {
                    setState(() {
                      selectedValue = v as String;
                    });
                  },
                  items: _languages?.map((valueItem) {
                    return DropdownMenuItem(
                        value: valueItem, child: Text(valueItem as String));
                  }).toList(),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 42,
                  underline: SizedBox(),
                ),

            const SizedBox(height: 35),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: _TextController,
                  style: TextStyle(color: Colors.grey[700]),
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.text_snippet,
                      color: Colors.black45,
                    ),
                    labelText: "Enter text to be translated",
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                )),

            const SizedBox(height: 35),

              Container(

                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await getTranslated(_TextController.text, selectedValue);

                    print(_convertandlang?[0]);
                    print(_convertandlang?[1]);
                    translatedtext=_convertandlang?[0];
                    detectedlang=_convertandlang?[1];
                  },
                  child: Text(
                    "CALL TRANSLATE API",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.grey.shade900;
                        }
                        return Colors.black;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
                ),
              ),
                const SizedBox(height:35),

                Text(
                  'Detected Language: '+detectedlang,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 35),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      style: TextStyle(color: Colors.grey[700]),
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.text_snippet,
                          color: Colors.black45,
                        ),
                        labelText: translatedtext,
                        labelStyle: TextStyle(color: Colors.grey[500]),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    )),



          ])),
        ));
  }
}
