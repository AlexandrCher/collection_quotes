import 'dart:convert';
import 'package:collection_quotes/models/quote.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://collection-quotes-default-rtdb.europe-west1.firebasedatabase.app/quotes';

class QuoteService {
  static Future<List<Quote>> fetchQuotes([String? category]) async {
    final url = category == null
        ? '$baseUrl.json'
        : '$baseUrl.json?orderBy="category"&equalTo="$category"';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) throw Exception('Error loading quotes');

    final data = json.decode(response.body) as Map<String, dynamic>?;
    if (data == null) return [];

    return data.entries
        .map((e) => Quote.fromMap(e.key, e.value))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  static Future<void> addQuote(Quote quote) async {
    await http.post(Uri.parse('$baseUrl.json'),
        body: json.encode(quote.toMap()));
  }

  static Future<void> updateQuote(Quote quote) async {
    await http.patch(Uri.parse('$baseUrl/${quote.id}.json'),
        body: json.encode(quote.toMap()));
  }

  static Future<void> deleteQuote(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id.json'));
  }
}
