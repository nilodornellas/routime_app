import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:routime_app/app/core/notifier/routime_change_notifier.dart';
import 'package:routime_app/app/core/ui/messages.dart';

class RoutimeListenerNotifier {
  final RoutimeChangeNotifier changeNotifier;

  RoutimeListenerNotifier({required this.changeNotifier});

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallback,
    EverCallback? everCallback,
    ErrorCallback? errorCallback,
  }) {
    changeNotifier.addListener(() {
      if (everCallback != null) {
        everCallback(changeNotifier, this);
      }

      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context)
            .showError(changeNotifier.error ?? 'Erro na operação');
      } else if (changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
    RoutimeChangeNotifier notifier, RoutimeListenerNotifier listnerInstance);

typedef ErrorCallback = void Function(
    RoutimeChangeNotifier notifier, RoutimeListenerNotifier listnerInstance);
typedef EverCallback = void Function(
    RoutimeChangeNotifier notifier, RoutimeListenerNotifier listnerInstance);
