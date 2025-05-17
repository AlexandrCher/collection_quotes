class Category {
  final String id;
  final String title;

  const Category({required this.id, required this.title});
}

const categories = [
  Category(id: 'star-wars', title: 'Star Wars'),
  Category(id: 'famous', title: 'Famous People'),
  Category(id: 'saying', title: 'Sayings'),
  Category(id: 'humour', title: 'Humour'),
  Category(id: 'motivational', title: 'Motivational'),
];
