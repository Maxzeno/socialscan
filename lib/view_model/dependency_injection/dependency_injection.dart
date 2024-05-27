import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../river_pod/network_connectivity_notifier.dart';

class DependencyInjection {
  static void init() {
    final connectivityProvider =
        StateNotifierProvider<ConnectivityNotifier, ConnectivityStatus>((ref) {
      return ConnectivityNotifier();
    });
  }
}
