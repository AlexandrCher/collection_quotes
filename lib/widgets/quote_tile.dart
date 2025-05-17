import 'package:collection_quotes/models/quote.dart';
import 'package:collection_quotes/screens/edit_quote_screen.dart';
import 'package:collection_quotes/services/quote_service.dart';
import 'package:flutter/material.dart';

class QuoteTile extends StatelessWidget {
  final Quote quote;

  const QuoteTile({super.key, required this.quote});

  void _edit(BuildContext context) {
    Navigator.pushNamed(
      context,
      EditQuoteScreen.routeName,
      arguments: quote,
    );
  }

  void _delete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Удалить цитату?'),
        content: const Text('Вы уверены, что хотите удалить эту цитату?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Отмена')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Удалить')),
        ],
      ),
    );
    if (confirmed ?? false) {
      await QuoteService.deleteQuote(quote.id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Цитата удалена')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text('"${quote.text}"'),
        subtitle: Text('${quote.author} — ${quote.createdAt.toLocal().toString().split(' ')[0]}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') _edit(context);
            if (value == 'delete') _delete(context);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Редактировать')),
            const PopupMenuItem(value: 'delete', child: Text('Удалить')),
          ],
        ),
      ),
    );
  }
}
