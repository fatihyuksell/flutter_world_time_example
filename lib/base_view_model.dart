import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:optimus_case/interaction_mixin.dart';

class BaseViewModel<VA> extends ChangeNotifier with InteractionMixin {
  VA? arguments;

  VA get args => arguments!;
  bool isBusy = false;
  bool mounted = false;
  bool _showLoading = false;
  bool _isDisposed = false;
  bool get isDisposed => _isDisposed;

  bool get showLoading => _showLoading;

  set showLoading(bool value) {
    _showLoading = value;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadingOverlay(value);
    });
  }

  void parseArgs([Object? args]) {
    if (args != null && args is VA) {
      arguments = args as VA?;
    }
    if (!mounted) {
      onBindingCreated();
      mounted = true;
    }
  }

  void notify() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @protected
  @visibleForTesting
  void onBindingCreated() {}

  void willDispose() {}

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  int _flowCount = 0;

  Future<void> flow<T extends Object?>(
    final Future<T> Function() callback, {
    final ValueChanged<T>? onSuccess,
    final void Function(
      StackTrace stackTrace,
      DioException dioError,
    )? onError,
    final bool showLoading = true,
    final bool showError = true,
    final bool stopOnError = true,
  }) async {
    _flowCount++;
    if (showLoading) {
      this.showLoading = true;
    }
    isBusy = true;
    notify();

    bool success = false;

    while (!success) {
      try {
        final T data = await callback();
        onSuccess?.call(data);
        success = true;
        notify();
      } on DioException catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        onError?.call(s, e);

        if (stopOnError) {
          if (showError) {
            _showGeneralErrorMessage(
              title: 'Error',
              description: e.message ?? 'An unexpected error occurred.',
            );
          }
          break;
        }

        debugPrint('Retrying...');
      } catch (e) {
        debugPrint('Unexpected error: $e');
        break;
      }
    }

    _flowCount--;
    if (_flowCount == 0) {
      this.showLoading = false;
    }
    isBusy = false;
    notify();
  }

  void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void addPostFrameCallback(VoidCallback callback) {
    SchedulerBinding.instance.addPostFrameCallback((_) => callback());
  }

  void _showGeneralErrorMessage({
    required String description,
    String? title,
  }) {
    Future.microtask(() {
      debugPrint('ErroMessage');
    });
  }
}
