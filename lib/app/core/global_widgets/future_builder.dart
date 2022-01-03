import 'package:flutter/material.dart';

import 'package:custom_utils/future.dart';

import 'package:shopping_app/app/core/global_widgets/widgets.dart';

class AppFutureBuilder extends StatelessWidget {
  final Future future;
  final Widget Function(AsyncSnapshot snapshot) builder;
  final Widget Function(AsyncSnapshot error)? errorBuilder;
  final Widget? loading;
  const AppFutureBuilder(
      {Key? key,
      required this.builder,
      required this.future,
      this.loading,
      this.errorBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: future,
      builder: builder,
      loading: loading ?? const CenterLoading(size: 38),
      errorBuilder: errorBuilder,
    );
  }
}
