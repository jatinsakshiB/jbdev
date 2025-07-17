import 'package:flutter/cupertino.dart';

GlobalKey<NavigatorState>? _externalNavigatorKey;

GlobalKey<NavigatorState> get jbNavigatorKey => _externalNavigatorKey ?? _defaultNavigatorKey;

final GlobalKey<NavigatorState> _defaultNavigatorKey = GlobalKey<NavigatorState>();

void setJbNavigatorKey(GlobalKey<NavigatorState> key) {
  _externalNavigatorKey = key;
}
