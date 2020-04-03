import 'package:flutter/foundation.dart';

class AppState {
  final bool _isLoading;

  AppState(this._isLoading);

  AppState.clone(AppState state) : this(state._isLoading);
}

class AppStateProvider with ChangeNotifier {
  bool _isLoading;
  int _itemViewIndex = 0;

  int get itemViewIndex {
    itemViewIndex = 1;
    return _itemViewIndex;
  }

  set itemViewIndex(int stepBy) {
    _itemViewIndex += stepBy;
  }

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
  }
}
