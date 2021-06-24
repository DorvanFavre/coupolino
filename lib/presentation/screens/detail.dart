import 'package:coupolino/constants/constants.dart';
import 'package:coupolino/domain/entities/article.dart';
import 'package:coupolino/presentation/components/slidable.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final Article article;

  Detail(this.article);

  @override
  Widget build(BuildContext context) {
    return Slidable(
        Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Image.asset(
              kImagePath + article.imagePath,
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ), () {
      Navigator.of(context).pop();
    }, (_) {});
  }
}
