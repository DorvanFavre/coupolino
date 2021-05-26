import 'package:coupolino/presentation/wrappers/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProvideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: MyApp());
  }
}
