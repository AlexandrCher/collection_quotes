import 'package:collection_quotes/screens/edit_quote_screen.dart';
import 'package:collection_quotes/screens/home_screen.dart';
import 'package:collection_quotes/screens/quote_list_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Цитатник',
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        QuoteListScreen.routeName: (_) => QuoteListScreen(),
        EditQuoteScreen.routeName: (_) => EditQuoteScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
