
import 'package:coupolino/domain/entities/article.dart';
import 'package:coupolino/domain/entities/filter.dart';
import 'package:coupolino/infrastructure/repositories/local_article_repository.dart';
import 'package:flutter/foundation.dart';

abstract class ArticleRepository{

  factory ArticleRepository(){
    return LocalArticleRepository();
  }

  Future<List<Article>> getAllArticles(Filter filter);
}