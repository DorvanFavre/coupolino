import 'package:coupolino/application/notifiers/articles_notifier.dart';
import 'package:coupolino/application/providers/article_repository_provider.dart';
import 'package:coupolino/domain/entities/article.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articlesNotifierProvider =
    StateNotifierProvider<ArticlesNotifier, List<Article>>((ref) {
  final articleRepository = ref.watch(articleRepositoryProvider);
  return ArticlesNotifier(articleRepository);
});
