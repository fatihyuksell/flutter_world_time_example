import 'package:flutter/cupertino.dart';
import 'package:optimus_case/base_view_model.dart';

class AppRepository extends ChangeNotifier {
  final List<BaseViewModel> _baseViewModels = [];

  void addBaseViewModel(BaseViewModel baseViewModel) {
    _baseViewModels.add(baseViewModel);
    Future.delayed(
      const Duration(milliseconds: 100),
      () => notifyListeners(),
    );
  }

  void removeViewModel(BaseViewModel baseViewModel) {
    _baseViewModels.remove(baseViewModel);
    Future.delayed(
      const Duration(milliseconds: 100),
      () => notifyListeners(),
    );
  }

  BaseViewModel get lastViewModel => _baseViewModels.last;
}
