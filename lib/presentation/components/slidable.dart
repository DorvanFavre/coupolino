import 'package:flutter/material.dart';

import 'dart:math';

class Slidable extends StatefulWidget {
  final Widget child;
  final void Function() onClose;
  final void Function(SlideController slideController) onCreate;

  Slidable(
       this.child,
      this.onClose,
      this.onCreate);

  @override
  _SlidableState createState() => _SlidableState();
}

void emptyFunction(SlideController _) {}

class _SlidableState extends State<Slidable> with TickerProviderStateMixin {
  AnimationController? _controller;

  double get maxHeight => MediaQuery.of(context).size.height;
  SlideController _slideController = SlideController();

  @override
  void initState() {
    super.initState();

    widget.onCreate(_slideController);

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300), value: 0);

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onClose();
      }
    });

    _slideController.addListener(() {
      _toggle();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onVerticalDragUpdate: _handleDragUpdate,
      onVerticalDragEnd: _handleDragEnd,
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
                0, _controller!.value * MediaQuery.of(context).size.height),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller!.value += details.primaryDelta! / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller!.isAnimating ||
        _controller!.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity > 0.0) {
      _controller!.fling(velocity: max(2.0, -flingVelocity));
    } else if (flingVelocity < 0.0) {
      _controller!.fling(velocity: min(-2.0, -flingVelocity));
    } else {
      _controller!.fling(velocity: _controller!.value < 0.5 ? -2.0 : 2.0);
    }
  }

  void _toggle() {
    final bool isOpen = _controller!.status == AnimationStatus.completed;
    _controller!.fling(velocity: isOpen ? -1 : 1);
    //isOpen ? _controller.reverse() : _controller.forward();
  }
}

class SlideController extends ChangeNotifier {
  void slideDown() {
    notifyListeners();
  }
}
