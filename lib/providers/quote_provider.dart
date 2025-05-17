import 'package:collection_quotes/models/quote.dart';
import 'package:collection_quotes/services/quote_service.dart';
import 'package:flutter/material.dart';

class QuoteProvider with ChangeNotifier {
  List<Quote> _quotes = [];
  bool isLoading = false;
  String? error;

  List<Quote> get quotes => _quotes;

  Future<void> loadQuotes([String? category]) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      _quotes = await QuoteService.fetchQuotes(category);
    } catch (e) {
      error = 'Failed to load quotes';
    }
    isLoading = false;
    notifyListeners();
  }
}
