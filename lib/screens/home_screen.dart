import 'package:collection_quotes/models/category.dart';
import 'package:collection_quotes/screens/edit_quote_screen.dart';
import 'package:collection_quotes/screens/quote_list_screen.dart';
import 'package:collection_quotes/widgets/category_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  void openCategory(BuildContext context, String? categoryId) {
    Navigator.pushNamed(
      context,
      QuoteListScreen.routeName,
      arguments: categoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Категории цитат')),
      body: GridView(
        padding: const EdgeInsets.all(16),
        children: [
          ...categories.map(
            (cat) => CategoryTile(
              category: cat,
              onTap: () => openCategory(context, cat.id),
            ),
          ),
          CategoryTile(
            category: Category(id: '', title: 'Все цитаты'),
            onTap: () => openCategory(context, null),
          ),
        ],
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.pushNamed(context, EditQuoteScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
