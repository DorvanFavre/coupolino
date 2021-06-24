import 'package:coupolino/domain/entities/article.dart';
import 'package:coupolino/domain/entities/filter.dart';
import 'package:coupolino/domain/repositories/article_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticlesNotifier extends StateNotifier<List<Article>> {
  final ArticleRepository articleRepository;
  ArticlesNotifier(this.articleRepository) : super([]) {
    getArticles(Filter.all);
  }

  void getArticles(Filter filter) {
    articleRepository
        .getAllArticles(filter)
        .then((articles) => state = articles);
  }
}
