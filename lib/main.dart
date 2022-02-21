import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';

void main() => runApp(const MyApp());

/*class OneJoke extends Padding {
  OneJoke({required EdgeInsetsGeometry padding}) : super(padding: padding);
  
}*/

/*
//Main page
Scaffold(
      appBar: AppBar(
        title: const Text('Jokes about Chuck Norris'),
      ),
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: const [
                //Image(
                //  image: Image.file('./random-grid.jpg'),
                //),
                Text("s"),
                Text("Here is short joke")
              ])),
    )
Seccond page
Scaffold(
            appBar: AppBar(title: const Text('Test')),
            body: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Text(categories[index]),
                  color: Color.fromARGB(136, 89, 89, 204),
                  alignment: Alignment.center,
                );
              },
            ))

*/

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
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: changeState,
                child: Text(jokeProvider.CATEGORIES[index]),
              ),
              color: const Color.fromARGB(136, 89, 89, 204),
              alignment: Alignment.center,
            );
          },
        ));
  }

  Widget getJokePage(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //Image(
                  //  image: Image.file('./random-grid.jpg'),
                  //),
                  const Text("s"),
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
                ])),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Categories'),
          icon: const Icon(Icons.abc_outlined),
          onPressed: changeState,
          focusColor: const Color.fromARGB(184, 95, 97, 192),
          backgroundColor: const Color.fromARGB(184, 60, 61, 144),
        ));
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
/*class JokePage extends StatelessWidget {
  const JokePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  //Image(
                  //  image: Image.file('./random-grid.jpg'),
                  //),
                  Text("s"),
                  Text("Here is short joke")
                ])),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Categories'),
          icon: const Icon(Icons.abc_outlined),
          onPressed: onPress,
          focusColor: const Color.fromARGB(184, 95, 97, 192),
          backgroundColor: const Color.fromARGB(184, 60, 61, 144),
        ));
  }
}*/

/*class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  List<String> __generate_cat_names() {
    const categories = <String>['cat1', 'cat2', 'cat3'];
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Test')),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Text(__generate_cat_names()[index]),
              color: Color.fromARGB(136, 89, 89, 204),
              alignment: Alignment.center,
            );
          },
        ));
  }
}
*/
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}


/*
Scaffold(
            appBar: AppBar(
              title: const Text('Jokes about Chuck Norris'),
            ),
            body: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      //Image(
                      //  image: Image.file('./random-grid.jpg'),
                      //),
                      Text("s"),
                      Text("Here is short joke")
                    ])),
            floatingActionButton: FloatingActionButton.extended(
              label: const Text('Categories'),
              icon: Icon(Icons.abc_outlined),
              onPressed: () {},
              focusColor: Color.fromARGB(184, 95, 97, 192),
              backgroundColor: Color.fromARGB(184, 60, 61, 144),
            )));
 */