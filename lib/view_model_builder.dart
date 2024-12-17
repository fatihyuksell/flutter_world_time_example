import 'package:flutter/material.dart';
import 'package:optimus_case/app_repository.dart';
import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/interaction_mixin.dart';
import 'package:optimus_case/navigator_util.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:provider/provider.dart';

// class ViewModelBuilder<T extends ChangeNotifier> extends StatefulWidget {
//   const ViewModelBuilder({
//     required this.initViewModel,
//     required this.builder,
//     super.key,
//   }) : reactive = true;

//   final T Function() initViewModel;
//   final Widget Function(BuildContext context, T value) builder;
//   final bool reactive;

//   const ViewModelBuilder.nonReactive({
//     required this.initViewModel,
//     required this.builder,
//     super.key,
//   }) : reactive = false;

//   @override
//   State<ViewModelBuilder<T>> createState() => _ViewModelBuilder<T>();
// }

// class _ViewModelBuilder<T extends ChangeNotifier>
//     extends State<ViewModelBuilder<T>> {
//   late final T viewModel;
//   bool _init = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_init) {
//       viewModel = widget.initViewModel();

//       if (viewModel is InteractionMixin) {
//         final interactionMixin = viewModel as InteractionMixin;
//         interactionMixin.navigate = _navigate;
//         interactionMixin.popAndNavigate = _popAndNavigate;
//         interactionMixin.pushReplacement = _pushReplacement;
//         interactionMixin.pop = _pop;
//         interactionMixin.canPop = _canPop;
//         interactionMixin.popUntilRoute = _popUntilRoute;
//         interactionMixin.loadingOverlay = _loading;
//         interactionMixin.theme = Theme.of(context);
//         interactionMixin.isCurrent = _isCurrent;
//       }

//       if (viewModel is BaseViewModel) {
//         final baseViewModel = viewModel as BaseViewModel;
//         baseViewModel.parseArgs(
//           ModalRoute.of(context)?.settings.arguments,
//         );
//         locator<AppRepository>().addBaseViewModel(baseViewModel);
//       }
//     }
//     _init = true;
//   }

//   bool _canPop({final bool rootNavigator = false}) {
//     return NavigatorUtil.instance.canPop(
//       context,
//       root: rootNavigator,
//     );
//   }

//   Future<R?>? _pushReplacement<R extends Object?>(
//     String routeName, {
//     Object? args,
//     Object? result,
//     bool rootNavigator = false,
//   }) {
//     return NavigatorUtil.instance.pushReplacement(
//       context,
//       routeName,
//       args: args,
//       root: rootNavigator,
//       result: result,
//     );
//   }

//   Future<R?>? _popAndNavigate<R extends Object?>(
//     String routeName, {
//     Object? args,
//     Object? result,
//     bool rootNavigator = false,
//   }) {
//     return NavigatorUtil.instance.popAndNavigate(
//       context,
//       routeName,
//       args: args,
//       root: rootNavigator,
//       result: result,
//     );
//   }

//   void _popUntilRoute(
//     String routeName, {
//     bool rootNavigator = false,
//   }) {
//     return NavigatorUtil.instance.popUntilRoute(
//       context,
//       routeName,
//       root: rootNavigator,
//     );
//   }

//   bool _isCurrent() => ModalRoute.of(context)?.isCurrent ?? false;

//   Future<R?>? _navigate<R extends Object?>(
//     String routeName, {
//     Object? args,
//     bool clearStack = false,
//     bool rootNavigator = false,
//   }) {
//     return NavigatorUtil.instance.call<R>(
//       context,
//       routeName,
//       args: args,
//       clearStack: clearStack,
//       root: rootNavigator,
//     );
//   }

//   void _pop<R extends Object?>({R? result, final bool rootNavigator = false}) {
//     return NavigatorUtil.instance.pop<R>(
//       context,
//       result: result,
//       rootNavigator: rootNavigator,
//     );
//   }

//   OverlayEntry? _overlayEntry;

//   void _loading(bool loading) {
//     if (loading) {
//       try {
//         _overlayEntry?.remove();
//       } catch (_) {
//       } finally {
//         _overlayEntry = OverlayEntry(
//           builder: (context) => Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 color: Colors.grey.withOpacity(.5),
//               ),
//               const CircularProgressIndicator.adaptive(),
//             ],
//           ),
//         );

//         if (mounted) {
//           Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
//         }
//       }
//     } else {
//       try {
//         _overlayEntry?.remove();
//       } catch (_) {
//       } finally {
//         _overlayEntry = null;
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
//       child: widget.reactive
//           ? ChangeNotifierProvider<T>(
//               create: (_) => viewModel,
//               child: Consumer<T>(
//                 builder: (context, viewModel, _) =>
//                     widget.builder(context, viewModel),
//               ),
//             )
//           : widget.builder(context, viewModel),
//     );
//   }

//   @override
//   void deactivate() {
//     if (viewModel is BaseViewModel) {
//       (viewModel as BaseViewModel).willDispose();
//     }
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//     if (viewModel is BaseViewModel) {
//       locator<AppRepository>().removeViewModel(viewModel as BaseViewModel);
//     }
//     super.dispose();
//   }
// }

class ViewModelBuilder<T extends ChangeNotifier> extends StatefulWidget {
  const ViewModelBuilder({
    required this.initViewModel,
    required this.builder,
    super.key,
  }) : reactive = true;

  final T Function() initViewModel;
  final Widget Function(BuildContext context, T value) builder;
  final bool reactive;

  const ViewModelBuilder.nonReactive({
    required this.initViewModel,
    required this.builder,
    super.key,
  }) : reactive = false;

  @override
  State<ViewModelBuilder<T>> createState() => _ViewModelBuilder<T>();
}

class _ViewModelBuilder<T extends ChangeNotifier>
    extends State<ViewModelBuilder<T>> {
  late final T viewModel;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      viewModel = widget.initViewModel();

      if (viewModel is InteractionMixin) {
        final interactionMixin = viewModel as InteractionMixin;
        interactionMixin.navigate = _navigate;
        interactionMixin.popAndNavigate = _popAndNavigate;
        interactionMixin.pushReplacement = _pushReplacement;

        interactionMixin.pop = _pop;
        interactionMixin.canPop = _canPop;
        interactionMixin.popUntilRoute = _popUntilRoute;
        interactionMixin.popUntilWithDefaultRoute = _popUntilWithDefaultRoute;
        interactionMixin.loadingOverlay = _loading;
        interactionMixin.theme = Theme.of(context);
        interactionMixin.isCurrent = _isCurrent;
      }

      if (viewModel is BaseViewModel) {
        final baseViewModel = viewModel as BaseViewModel;
        baseViewModel.parseArgs(
          ModalRoute.of(context)?.settings.arguments,
        );
        locator<AppRepository>().addBaseViewModel(baseViewModel);
      }
    }
    _init = true;
  }

  bool _canPop({final bool rootNavigator = false}) {
    return NavigatorUtil.instance.canPop(
      context,
      root: rootNavigator,
    );
  }

  Future<R?>? _pushReplacement<R extends Object?>(
    String routeName, {
    Object? args,
    Object? result,
    bool rootNavigator = false,
  }) {
    return NavigatorUtil.instance.pushReplacement(
      context,
      routeName,
      args: args,
      root: rootNavigator,
      result: result,
    );
  }

  Future<R?>? _popAndNavigate<R extends Object?>(
    String routeName, {
    Object? args,
    Object? result,
    bool rootNavigator = false,
  }) {
    return NavigatorUtil.instance.popAndNavigate(
      context,
      routeName,
      args: args,
      root: rootNavigator,
      result: result,
    );
  }

  void _popUntilRoute(
    String routeName, {
    bool rootNavigator = false,
  }) {
    return NavigatorUtil.instance.popUntilRoute(
      context,
      routeName,
      root: rootNavigator,
    );
  }

  bool _isCurrent() => ModalRoute.of(context)?.isCurrent ?? false;

  void _popUntilWithDefaultRoute({
    required String routeName,
    required String defaultRouteName,
    final bool root = false,
  }) {
    Navigator.of(context, rootNavigator: root).popUntil(
      (route) =>
          route.settings.name == routeName ||
          route.settings.name == defaultRouteName,
    );
  }

  Future<R?>? _navigate<R extends Object?>(
    String routeName, {
    Object? args,
    bool clearStack = false,
    bool rootNavigator = false,
  }) {
    return NavigatorUtil.instance(
      context,
      routeName,
      args: args,
      clearStack: clearStack,
      root: rootNavigator,
    );
  }

  // Future<R?> _dialog<R extends Object?>(final DialogArgs args) {
  //   return DialogUtil.instance<R>(context, args);
  // }

  // // ignore: avoid_shadowing_type_parameters
  // Future<T?> _customDialog<T extends Object?>(
  //   final Widget child, {
  //   final bool dismissible = true,
  // }) {
  //   return DialogUtil.instance.customDialog<T>(
  //     context,
  //     child,
  //     dismissible: dismissible,
  //   );
  // }

  void _pop<R extends Object?>({R? result, final bool rootNavigator = false}) {
    return NavigatorUtil.instance.pop<R>(
      context,
      result: result,
      rootNavigator: rootNavigator,
    );
  }

  OverlayEntry? _overlayEntry;

  void _loading(bool loading) {
    if (loading) {
      _overlayEntry?.remove();
      _overlayEntry = OverlayEntry(
        builder: (context) => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.black.withOpacity(.4),
            ),
            const CircularProgressIndicator.adaptive(
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: widget.reactive
          ? ChangeNotifierProvider<T>(
              create: (_) => viewModel,
              child: Consumer<T>(
                builder: (context, viewModel, _) =>
                    widget.builder(context, viewModel),
              ),
            )
          : widget.builder(context, viewModel),
    );
  }

  @override
  void deactivate() {
    if (viewModel is BaseViewModel) {
      (viewModel as BaseViewModel).willDispose();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _overlayEntry?.dispose();
    if (viewModel is BaseViewModel) {
      locator<AppRepository>().removeViewModel(viewModel as BaseViewModel);
    }
    super.dispose();
  }
}
