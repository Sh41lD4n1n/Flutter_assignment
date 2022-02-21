import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';

void main() => runApp(const MyApp());

class JokeProvider {
  List CATEGORIES = [];
  String current_category = "random";
  final String text = "";
  JokeProvider() {
    set_categories();
  }
  Future<void> set_categories() async {
    var resp = await http
        .get(Uri.parse('https://api.chucknorris.io/jokes/categories'));

    CATEGORIES = jsonDecode(resp.body);
  }

  void setCurrentCategory(String cat) {
    current_category = cat;
  }

  String getCurrentCategory() {
    return "";
  }

  Future<String> getJoke() async {
    var resp =
        await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

    return jsonDecode(resp.body)["value"];
  }
}

/*class JokeObject extends InheritedWidget {
  const JokeObject({Key? key, required Widget child})
      : super(key: key, child: child);
  //final JokeProvider jokeprovifer;
  final String text = "String";
  final List<String> categories = const ["stre"];
  static JokeObject of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<JokeObject>()!;

  @override
  bool updateShouldNotify(covariant JokeObject oldWidget) {
    return text != oldWidget.text || categories != oldWidget.categories;
  }
}
*/

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int state = 0;
  final JokeProvider jokeProvider = JokeProvider();

  Widget getCategoryPage() {
    return Scaffold(
        appBar: AppBar(title: const Text('Test')),
        body: ListView.builder(
          itemCount: jokeProvider.CATEGORIES.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  primary: Color.fromARGB(255, 255, 255, 255),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  jokeProvider
                      .setCurrentCategory(jokeProvider.CATEGORIES[index]);
                  changeState();
                },
                child: Text(jokeProvider.CATEGORIES[index]),
              ),
              color: const Color.fromARGB(136, 89, 89, 204),
              alignment: Alignment.center,
            );
          },
        ));
  }

  Widget getJokePage(BuildContext context) {
    final String cat = jokeProvider.current_category;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset('image.jpg'),
                  Text(cat),
                  FutureBuilder(
                      future: jokeProvider.getJoke(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return SafeArea(
                            child: Text(snapshot.data!),
                            left: true,
                            right: true,
                            bottom: true,
                            minimum: EdgeInsets.all(10.0),
                          );
                        } else {
                          return const SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset('image2.jpg'),
                  Text(cat),
                  FutureBuilder(
                      future: jokeProvider.getJoke(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return SafeArea(
                            child: Text(snapshot.data!),
                            left: true,
                            right: true,
                            bottom: true,
                            minimum: EdgeInsets.all(10.0),
                          );
                        } else {
                          return const SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ]),
          ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Column(
        children: <Widget>[
          FloatingActionButton.extended(
            label: const Text('Categories'),
            icon: const Icon(Icons.abc_outlined),
            onPressed: changeState,
            focusColor: const Color.fromARGB(184, 95, 97, 192),
            backgroundColor: const Color.fromARGB(184, 60, 61, 144),
          ),
          FloatingActionButton.extended(
            label: const Text('About'),
            icon: const Icon(Icons.account_circle_sharp),
            onPressed: () {
              setState(() {
                state = 2;
              });
            },
            focusColor: const Color.fromARGB(184, 95, 97, 192),
            backgroundColor: const Color.fromARGB(184, 60, 61, 144),
          ),
          FloatingActionButton.extended(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                state = 0;
              });
            },
            focusColor: const Color.fromARGB(184, 95, 97, 192),
            backgroundColor: const Color.fromARGB(184, 60, 61, 144),
            label: const Text(""),
          )
        ],
      ),
    );
  }

  Widget getAbout() {
    return Column(children: [
      const Padding(
        child: Text(
            "This application was done by student Danil Shalagin. This app take jokes about Chack Noris"),
        padding: EdgeInsets.all(16.0),
      ),
      Center(
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  state = 0;
                });
              },
              child: const Text('Get some jokes')))
    ]);
  }

  void changeState() {
    setState(() {
      state = (state + 1) % 2;
    });
  }

  Widget getPage(BuildContext context) {
    switch (state) {
      case 0:
        return getJokePage(context);
      case 1:
        return getCategoryPage();
      case 2:
        return getAbout();
    }
    throw Exception('Page doesnt exist');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Jokes about Chuck Norris'),
        ),
        body: getPage(context));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
