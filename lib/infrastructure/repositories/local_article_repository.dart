import 'package:coupolino/domain/entities/article.dart';
import 'package:coupolino/domain/entities/filter.dart';
import 'package:coupolino/domain/repositories/article_repository.dart';

final List<Article> articles = [
  Article('Garance', DateTime(2021, 06, 05, 22, 00), 'soiree_garance.jpg', number: '04'),
  Article('Techno Underground', DateTime(2021, 04, 30, 22, 00), 'rolex.jpg', number: '03'),
  Article('Bring back the 90s', DateTime(2021, 04, 23, 21, 00), 's90.jpg',number: '02'),
  Article('Tech vibration', DateTime(2021, 04, 16, 20, 00), 'tech.jpg', number: '01'),
  
];

class LocalArticleRepository implements ArticleRepository {
  @override
  Future<List<Article>> getAllArticles(Filter filter) {
    switch (filter) {
      case Filter.future:
        return Future.value(articles
            .where((element) => element.time.isAfter(DateTime.now()))
            .toList());

      case Filter.past:
        return Future.value(articles
            .where((element) => element.time.isBefore(DateTime.now()))
            .toList());
      default:
        return Future.value(articles);
    }
  }
}
