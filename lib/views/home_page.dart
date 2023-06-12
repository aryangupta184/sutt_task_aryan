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

  double height=200;

  void fetchTransData(BuildContext context, [bool mounted = true]) async {
    showDialog(

        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });


    await getTranslated(_TextController.text, selectedValue);


    if (!mounted) return;
    Navigator.of(context).pop();
  }

  void fetchLangData(BuildContext context, [bool mounted = true]) async {
    showDialog(

        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });


    await getLanguages();

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  String? username = SignInPage.sendusername.toString();

  Future<void> getLanguages() async {
    _languages = await LanguageApi.getLanguage();
    setState(() {});
  }

  Future<void> getTranslated(message, toLanguageCode) async {
    _convertandlang = await TranslationApi.translate(message, toLanguageCode);
    translatedtext = _convertandlang?[0];
    detectedlang = _convertandlang?[1];
    setState(() {});
  }

  static const snackBar = SnackBar(
    content: Text('User Signed Out Successfully'),
  );

  String? selectedValue;
  String translatedtext = 'Call APIs';
  String detectedlang = 'Call APIs';
  String langactivated = '';
  String translateactivated = '';

  TextEditingController _TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            leading: Icon(
              Icons.account_circle_rounded,
              color: Colors.blueGrey[100],
            ),
            backgroundColor: Colors.blue,
            elevation: 16,
            shadowColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            title: Text(
              "Hi, " + username!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            centerTitle: false,
            actions: [
              Container(
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      SignInPage.sendusername='User';
                      FirebaseServices().signOut();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      GoRouter.of(context).push(APP_PAGE.home.toPath);
                    },
                    child: Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.blueGrey.shade100,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  )),
            ],
          ),
          SliverToBoxAdapter(
              child: SafeArea(
            child: Center(
                child: Column(children: [

                  Container(
                    height: height*0.39,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.g_translate,
                          color: Colors.blue,
                          size: 100,
                        ),
                        const SizedBox(height: 30),

                        Container(
                          child: ElevatedButton(
                              onPressed: () {
                                fetchLangData(context);
                                langactivated = "Drop Down List Activated";
                              },
                              child: Text(
                                "CALL LANGUAGE CODE API",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  fixedSize: Size(250, 36),
                                  elevation: 22,
                                  shadowColor: Colors.lightBlueAccent,
                                  side: BorderSide(color: Colors.blue),
                                  shape: StadiumBorder())),
                        ),

                        const SizedBox(height: 10),
                        Text(
                          langactivated,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
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

                      ],
                    ),
                  ),
                  Container(
                    height: height*0.5,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[200],
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextField(
                              controller: _TextController,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue.shade400),
                                ),
                                fillColor: Colors.white54,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.text_snippet,
                                  color: Colors.blue,
                                ),
                                labelText: "Enter text to be translated",
                                labelStyle: TextStyle(color: Colors.black),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              ),
                            )),
                        const SizedBox(height: 35),
                        Container(
                          child: ElevatedButton(
                              onPressed: () {
                                fetchTransData(context);
                                translateactivated = 'Translation Successful';

                                print(_convertandlang?[0]);
                                print(_convertandlang?[1]);

                              },
                              child: Text(
                                "CALL TRANSLATE API",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  fixedSize: Size(250, 36),
                                  elevation: 22,
                                  shadowColor: Colors.lightBlueAccent,
                                  side: BorderSide(color: Colors.blue),
                                  shape: StadiumBorder())),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          translateactivated,
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Detected Language: ' + detectedlang,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 35),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextField(
                              style: TextStyle(color: Colors.black45),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue.shade400),
                                ),
                                fillColor: Colors.white54,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.text_snippet,
                                  color: Colors.blue,
                                ),
                                labelText: translatedtext,
                                labelStyle: TextStyle(color: Colors.blueGrey),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              ),
                            )),

                      ],
                    )

                  )

            ])),
          ))
        ],
      ),


    );



  }
}
