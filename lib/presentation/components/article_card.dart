import 'package:coupolino/constants/constants.dart';
import 'package:coupolino/domain/entities/article.dart';
import 'package:coupolino/presentation/screens/detail.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  ArticleCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, __) => Detail(article))),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.height / 2.5,
          decoration: ShapeDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(kImagePath + article.imagePath)),
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
        ),
      ),
    );
  }
}
