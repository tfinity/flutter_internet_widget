import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetController {
  InternetController._() {
    _startStream();
  }

  static final InternetController _instance = InternetController._();
  factory InternetController() => _instance;

  ValueNotifier<bool?> get hasConnection => _isInternetConnected;

  final ValueNotifier<bool?> _isInternetConnected = ValueNotifier(null);

  bool currentInternetStatus = true;

  void _startStream() {
    InternetConnection().onStatusChange.listen((event) async {
      final isConnected = event == InternetStatus.connected;
      if (isConnected == currentInternetStatus) {
        return;
      }
      _isInternetConnected.value = currentInternetStatus = isConnected;
    });
  }

  Stream<InternetStatus> get getStatusStrem {
    return InternetConnection().onStatusChange;
  }

  Future<InternetStatus> get getCurrentInternetStatus async {
    return await InternetConnection().internetStatus;
  }
}
