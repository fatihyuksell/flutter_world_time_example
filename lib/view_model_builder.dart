import 'package:flutter/material.dart';
import 'package:optimus_case/app_repository.dart';
import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/interaction_mixin.dart';
import 'package:optimus_case/navigator_util.dart';
import 'package:optimus_case/utils/args/dialog_args.dart';
import 'package:optimus_case/utils/dialog_util.dart';
import 'package:optimus_case/utils/locator.dart';
import 'package:optimus_case/utils/tutorial_util.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ViewModelBuilder<T extends ChangeNotifier> extends StatefulWidget {
  const ViewModelBuilder({
    required this.initViewModel,
    required this.builder,
    this.onAfterViewModelInit,
    super.key,
  }) : reactive = true;

  final T Function() initViewModel;
  final Widget Function(BuildContext context, T value) builder;
  final bool reactive;
  final Function(BuildContext context, T value)? onAfterViewModelInit;

  const ViewModelBuilder.nonReactive({
    required this.initViewModel,
    required this.builder,
    this.onAfterViewModelInit,
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
        interactionMixin.pop = _pop;
        interactionMixin.canPop = _canPop;
        interactionMixin.loadingOverlay = _loading;
        interactionMixin.theme = Theme.of(context);
        interactionMixin.dialog = _dialog;
        interactionMixin.tutorial = _tutorial;
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

  Future<TutorialCoachMark> _tutorial<R extends Object?>(
    final List<TargetFocus> targets,
  ) async {
    return TutorialCoachMarkUtil.instance.showTutorial(
      context: context,
      targets: targets,
    );
  }

  Future<R?> _dialog<R extends Object?>(final DialogArgs args) {
    return DialogUtil.instance.dialog<R>(context, args);
  }

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
