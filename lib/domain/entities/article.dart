class Article {
  final String title;
  final DateTime time;
  final String imagePath;
  final String number;

  const Article(this.title, this.time, this.imagePath, {this.number = '00'});
}
