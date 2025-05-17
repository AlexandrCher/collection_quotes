import 'package:collection_quotes/providers/quote_provider.dart';
import 'package:collection_quotes/widgets/quote_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuoteListScreen extends StatelessWidget {
  static const routeName = '/quotes';

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)?.settings.arguments as String?;

    return ChangeNotifierProvider(
      create: (_) => QuoteProvider()..loadQuotes(categoryId),
      child: Consumer<QuoteProvider>(
        builder: (ctx, provider, _) {
          if (provider.isLoading)
            return const Center(child: CircularProgressIndicator());
          if (provider.error != null)
            return Center(child: Text(provider.error!));
          if (provider.quotes.isEmpty)
            return const Center(child: Text('Цитат нет'));

          return ListView.builder(
            itemCount: provider.quotes.length,
            itemBuilder: (ctx, i) => QuoteTile(quote: provider.quotes[i]),
          );
        },
      ),
    );
  }
}
