import 'package:collection_quotes/models/category.dart';
import 'package:collection_quotes/models/quote.dart';
import 'package:collection_quotes/services/quote_service.dart';
import 'package:flutter/material.dart';

class EditQuoteScreen extends StatefulWidget {
  static const routeName = '/edit';

  @override
  State<EditQuoteScreen> createState() => _EditQuoteScreenState();
}

class _EditQuoteScreenState extends State<EditQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool isEditing;
  late Quote? existingQuote;

  String _author = '';
  String _text = '';
  String _category = categories.first.id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Quote) {
      isEditing = true;
      existingQuote = args;
      _author = args.author;
      _text = args.text;
      _category = args.category;
    } else {
      isEditing = false;
      existingQuote = null;
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final newQuote = Quote(
      id: existingQuote?.id ?? '',
      author: _author,
      text: _text,
      category: _category,
      createdAt: existingQuote?.createdAt ?? DateTime.now(),
    );

    if (isEditing) {
      await QuoteService.updateQuote(newQuote);
    } else {
      await QuoteService.addQuote(newQuote);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Редактировать цитату' : 'Новая цитата')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _text,
                decoration: const InputDecoration(labelText: 'Текст цитаты'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Введите текст' : null,
                onSaved: (value) => _text = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _author,
                decoration: const InputDecoration(labelText: 'Автор'),
                validator: (value) => value == null || value.isEmpty ? 'Введите автора' : null,
                onSaved: (value) => _author = value!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Категория'),
                items: categories
                    .map((cat) => DropdownMenuItem(
                  value: cat.id,
                  child: Text(cat.title),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _save,
                child: const Text('Сохранить'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
