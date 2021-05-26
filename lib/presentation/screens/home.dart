import 'package:coupolino/presentation/components/bottom_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        Container(
          decoration: const BoxDecoration(color: Colors.black),
        ),
        // pageview
        PageView.builder(itemBuilder: (context, index) {
          return const SizedBox.shrink();
        }),

        // HUD
        Padding(
          padding: EdgeInsets.all(30),
          child: Stack(
            children: [
              // BottomBar
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomBar(),
              )
            ],
          ),
        )
        // BottomBar
      ],
    );
  }
}
