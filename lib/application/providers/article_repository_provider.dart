import 'package:coupolino/domain/repositories/article_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final articleRepositoryProvider = Provider<ArticleRepository>((ref) {
  return ArticleRepository();
});
