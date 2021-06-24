import 'package:coupolino/application/providers/articles_notifier_provider.dart';
import 'package:coupolino/application/providers/editing_state_provider.dart';
import 'package:coupolino/presentation/components/article_card.dart';
import 'package:coupolino/presentation/components/article_info.dart';
import 'package:coupolino/presentation/components/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageController = PageController(viewportFraction: 0.7);

    return Stack(
      children: [
        // Background
        Container(
          decoration: const BoxDecoration(color: Colors.black),
        ),

        // pageview
        Align(
          alignment: Alignment(0, 0.3),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Consumer(
              builder: (context, watch, child) {
                final articles = watch(articlesNotifierProvider);

                return PageView.builder(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return ArticleCard(article);
                  },
                );
              },
            ),
          ),
        ),

        // HUD
        Padding(
          padding: EdgeInsets.all(30),
          child: Stack(
            children: [
              // Article info
              Align(
                alignment: Alignment.topLeft,
                child: ArticleInfo(pageController),
              ),
              // BottomBar
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomBar(pageController),
              )
            ],
          ),
        ),
      ],
    );
  }
}
