import 'package:flutter/material.dart';
import 'package:optimus_case/base_view_model.dart';
import 'package:optimus_case/enums/shared_constants.dart';
import 'package:optimus_case/models/localization_strings.dart';
import 'package:optimus_case/routes/static_routes.dart';
import 'package:optimus_case/services/local/shared_preferences_manager.dart';
import 'package:optimus_case/services/local/theme_manager.dart';
import 'package:optimus_case/services/remote/services/time_information_service/time_information_service.dart';
import 'package:optimus_case/utils/args/dialog_args.dart';
import 'package:optimus_case/utils/args/dialog_result.dart';
import 'package:optimus_case/utils/tutorial_target_widget.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeViewModel extends BaseViewModel {
  //DEPENDENCY INJECTION PART
  final ThemeManager _themeManager;
  final TimeInformationService _timeInformationService;
  final SharedPreferenceManager _sharedPreferenceManager;

  HomeViewModel(this._themeManager, this._timeInformationService,
      this._sharedPreferenceManager);
  ThemeMode get themeMode => _themeManager.themeMode;
  //DEPENDENCY INJECTION PART

  //TUTORIALS KEY
  final GlobalKey searchKey = GlobalKey();
  final GlobalKey listKey = GlobalKey();
  final GlobalKey searchBarTitle = GlobalKey();
  late TutorialCoachMark tutorialCoachMark;
  //TUTORIALS KEY

  //SEARCHBAR NECESSITIES
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  final GlobalKey textFieldKey = GlobalKey();
  double textFieldHeight = 48.0;
  List<String> regionList = [];
  List<String> _filteredRegionList = [];

  set deviceName(String value) {
    _deviceName.text = value;
    notify();
  }
  //SEARCHBAR NECESSITIES

  bool isLoading = false;
  bool isSearchEmpty = false;

  //DIALOG TEXTS USERNAME OR OPTIMUS DEVELOPER DEFAULT
  String get deviceName =>
      _sharedPreferenceManager.get(SharedConstants.deviceName.value) ??
      _deviceName.text;
  final TextEditingController _deviceName = TextEditingController();
  //DIALOG TEXTS USERNAME OR OPTIMUS DEVELOPER DEFAULT

  @override
  void onBindingCreated() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await takeNameAndShowDialog();
    });
    await init();
    await calculateTextFieldHeight();
    _filteredRegionList = regionList;
  }

  Future<void> init() async {
    await getRegionDetails();
  }

  List<String> get filteredRegionList {
    if (searchController.text.isNotEmpty && _filteredRegionList.isEmpty) {
      return [];
    }
    return _filteredRegionList.isEmpty ? regionList : _filteredRegionList;
  }

  void updateSearchQuery(String text) {
    final query = searchController.text;
    _filteredRegionList = regionList
        .where((region) => region.toLowerCase().contains(query.toLowerCase()))
        .toList();

    isSearchEmpty = _filteredRegionList.isEmpty;
    notify();
  }

  void onPressedChangedUsername(String username) {
    takeNameAndShowDialog(username: username);
  }

  Future<void> takeNameAndShowDialog({String? username}) async {
    final storedDeviceName = _sharedPreferenceManager.get<String>(
          SharedConstants.deviceName.value,
        ) ??
        LocalizationStrings.optimusDeveloper;

    final initialDeviceName = username ?? storedDeviceName;

    final tempController = TextEditingController(text: initialDeviceName);

    await dialog<DialogResult>(
      DialogArgs.takeTheUsername(initialDeviceName, tempController),
    ).then((value) async {
      if (value == null || !value.isConfirmed) {
        return;
      }
      final newDeviceName = tempController.text.isNotEmpty
          ? tempController.text
          : LocalizationStrings.optimusDeveloper;

      await _sharedPreferenceManager.set(
        SharedConstants.deviceName.value,
        newDeviceName,
      );
      _deviceName.text = newDeviceName;

      final isTutorialShown = _sharedPreferenceManager
              .get<bool>(SharedConstants.isTutorialShown.value) ??
          false;

      if (isTutorialShown) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showTutorial();
        });
      }
    });
    notify();
  }

  Future<void> showTutorial() async {
    tutorial(
      [
        TutorialTargetFocus.createTargetFocus(
          identify: "SearchBar",
          keyTarget: searchKey,
          themeManager: _themeManager,
          title: LocalizationStrings.devicePersonalInfos,
          description:
              LocalizationStrings.devicePersonalInfoDesc(_deviceName.text),
          align: ContentAlign.bottom,
        ),
        TutorialTargetFocus.createTargetFocus(
          identify: "AnotherTarget",
          keyTarget: listKey,
          themeManager: _themeManager,
          title: LocalizationStrings.anotherFeature,
          description: LocalizationStrings.anotherFeatureDescription,
          align: ContentAlign.top,
        ),
      ],
    );
    await _sharedPreferenceManager.set(
      SharedConstants.isTutorialShown.value,
      true,
    );
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    await _themeManager.toggleTheme(mode);
    notify();
  }

  Future<void> getRegionDetails() async {
    isLoading = true;
    notify();

    await flow(
      () async {
        final response = await _timeInformationService.getTimezones();

        if (response.isNotEmpty) {
          regionList = response;
        } else {
          regionList.clear();
        }
        _filteredRegionList = regionList;
        isLoading = false;
        debugPrint('$response');
      },
      stopOnError: false,
      showLoading: false,
    );

    notify();
  }

  Future<void> calculateTextFieldHeight() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      textFieldHeight = 48.0;
      notify();
    });
  }

  void onItemPressed(String region) {
    navigate(
      Routes.timeZoneDetails,
      args: region,
    );
  }

  Future<void> onPageRefreshed() async {
    searchController.clear();
    _filteredRegionList = regionList;
    notify();

    regionList.clear();
    await init();
    notify();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _deviceName.dispose();
    super.dispose();
  }
}
