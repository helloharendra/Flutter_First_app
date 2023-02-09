import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext(){                   //added getNext method
    current=WordPair.random();
    notifyListeners();
  }

  var favorites=<WordPair>[]; // here [] is list(empty list)
  void toggleFavorite(){
    if(favorites.contains(current)){
      favorites.remove(current);
    }else{
      favorites.add(current);
    }
    notifyListeners();

  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair=appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)){
      icon= Icons.favorite;
    }else{
      icon=Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('A random AWESOME idea:'),
            BigCard(pair: pair),
            SizedBox(height: 10),
            // Text('UpperCase : '+appState.current.asUpperCase),
            // Text('LowerCase : '+appState.current.asLowerCase),
            // Text('CamelCase : '+appState.current.asCamelCase),
            // Text('PascalCase : '+appState.current.asPascalCase),
            // Text('SnakeCase : '+appState.current.asSnakeCase),
            // Text('String : '+appState.current.asString),

            
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                ElevatedButton.icon(
                  onPressed: (){
                    appState.toggleFavorite();
                  }, icon: Icon(icon), label: Text('Like'),),
                  SizedBox(width: 10),
                ElevatedButton(onPressed: (){           // Next Button Added
                  // print('Next Button Pressed');
                  appState.getNext();
                },
                child: Text('Next'), ),
              ],
            ),
            // ElevatedButton(onPressed: (){      // Cancel Button Added
            //   print('Cancel button pressed');
            // },
            // child: Text('Cancel'),
            // ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    var style=theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.surface,
    );

    return  Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(25.0),

        child: Text(pair.asLowerCase,
         style: style, 
         semanticsLabel: pair.asPascalCase,),
      ),
    );
  }
}