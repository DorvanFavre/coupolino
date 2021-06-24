import 'package:coupolino/application/providers/articles_notifier_provider.dart';
import 'package:coupolino/domain/entities/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends StatefulWidget {
  final PageController pageController;

  BottomBar(this.pageController);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final ValueNotifier<Filter> selectedFilterNotifier =
      ValueNotifier(Filter.all);

  ValueNotifier<int> numberNotifer = ValueNotifier(0);

  @override
  void initState() {
    super.initState();

    widget.pageController.addListener(() {
      if (widget.pageController.page!.round() != numberNotifer.value) {
        numberNotifer.value = widget.pageController.page!.round();
      }
    });

    context.read(articlesNotifierProvider.notifier).addListener((state) {
      print('change');
      numberNotifer.value = 0;
      numberNotifer.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1,
          color: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: numberNotifer,
              builder: (context, value, child) {
                final articles = context.read(articlesNotifierProvider);
                if (articles.length > value) {
                  final text = articles[value].number;
                  return Padding(
                    padding: const EdgeInsets.only(top:5.0),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
            SizedBox.shrink(),
            FilterButton(
              Filter.all,
              selectedFilterNotifier,
              text: 'ALL',
            ),
            FilterButton(
              Filter.future,
              selectedFilterNotifier,
              text: 'FUTURE',
            ),
            FilterButton(
              Filter.past,
              selectedFilterNotifier,
              text: 'PAST',
            ),
          ],
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final Filter filter;
  final String text;
  final ValueNotifier<Filter> selectedFilterNotifier;

  FilterButton(this.filter, this.selectedFilterNotifier, {this.text = '-'});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedFilterNotifier.value = filter;
        context.read(articlesNotifierProvider.notifier).getArticles(filter);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<Filter>(
            valueListenable: selectedFilterNotifier,
            builder: (context, value, child) => AnimatedOpacity(
              opacity: value == filter ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Container(
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(3),
                            bottomRight: Radius.circular(3)))),
                height: 4,
                width: 20,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
