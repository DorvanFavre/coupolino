import 'package:coupolino/application/providers/articles_notifier_provider.dart';
import 'package:coupolino/domain/entities/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterButton(
          Filter.all,
          text: 'ALL',
        ),
        FilterButton(
          Filter.future,
          text: 'FUTURE',
        ),
        FilterButton(
          Filter.past,
          text: 'PAST',
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final Filter filter;
  final String text;

  FilterButton(this.filter, {this.text = '-'});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read(articlesNotifierProvider.notifier).loadArticles(filter);
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
