import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:routime_app/app/core/modules/routime_page.dart';

abstract class RoutimeModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  RoutimeModule({
    List<SingleChildWidget>? bindings,
    required Map<String, WidgetBuilder> routers,
  })  : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => RoutimePage(
          bindings: _bindings,
          page: pageBuilder,
        ),
      ),
    );
  }
}
