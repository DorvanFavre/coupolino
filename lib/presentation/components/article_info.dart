import 'package:coupolino/application/providers/articles_notifier_provider.dart';
import 'package:coupolino/domain/entities/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

class ArticleInfo extends StatefulWidget {
  final PageController pageController;

  ArticleInfo(this.pageController);

  @override
  _ArticleInfoState createState() => _ArticleInfoState();
}

class _ArticleInfoState extends State<ArticleInfo>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? translateAnimation;
  Animation? opacityAnimation;
  ValueNotifier<Article?> currentArticleNotifier = ValueNotifier(null);
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();

    //final firstArticle = context.read(articlesNotifierProvider)[0];

    context.read(articlesNotifierProvider.notifier).addListener((state) {
      articles = state;
      if (articles.length > 0) {
        currentArticleNotifier.value = articles[0];
      }
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    translateAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(-20, 0))
        .animate(CurvedAnimation(
            parent: animationController!, curve: Curves.easeIn));

    opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: animationController!, curve: Curves.easeIn));

    widget.pageController.addListener(() {
      if (widget.pageController.page! -
              widget.pageController.page!.roundToDouble() !=
          0) {
        if (animationController!.status != AnimationStatus.forward) {
          animationController!.forward();
        }
      } else {
        if (animationController!.status != AnimationStatus.reverse) {
          final index = widget.pageController.page!.round();

          currentArticleNotifier.value = articles[index];
          animationController!.reverse();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 1,
          color: Colors.white,
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top:30),
              child: IconButton(
                onPressed: () {
                  final instagramUrl = "https://www.instagram.com/coupolino/";
                  try {
                    launch(instagramUrl);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Can't launch Instagram"),
                    ));
                  }
                },
                icon: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.white,
                ),
              ),
            )),
        AnimatedBuilder(
          animation: animationController!,
          builder: (context, child) {
            return Transform.translate(
              offset: translateAnimation!.value,
              child: Opacity(opacity: opacityAnimation!.value, child: child),
            );
          },
          child: ValueListenableBuilder(
            valueListenable: currentArticleNotifier,
            builder: (context, value, child) => Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentArticleNotifier.value?.title ?? '',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    (currentArticleNotifier.value?.time.day.toString() ?? '') +
                        ' ' +
                        months[currentArticleNotifier.value?.time.month ?? 0] +
                        ' ' +
                        (currentArticleNotifier.value?.time.year.toString() ??
                            ''),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
