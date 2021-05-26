import 'package:coupolino/domain/entities/article.dart';
import 'package:coupolino/domain/entities/filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticlesNotifier extends StateNotifier<List<Article>> {
  ArticlesNotifier() : super([]);

  void loadArticles(Filter filter) {
    print(filter);
    state = List.generate(5, (index) => Article());
  }
}
