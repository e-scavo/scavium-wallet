import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/assets/application/assets_controller.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/blockchain/application/network_info_controller.dart';
import 'package:scavium_wallet/features/blockchain/application/rpc_status_controller.dart';
import 'package:scavium_wallet/features/lock/application/app_lock_state_controller.dart';

final homeAutoRefreshControllerProvider =
    NotifierProvider<HomeAutoRefreshController, bool>(
      HomeAutoRefreshController.new,
    );

class HomeAutoRefreshController extends Notifier<bool> {
  Timer? _timer;

  @override
  bool build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return false;
  }

  void start({Duration interval = const Duration(seconds: 15)}) {
    _timer?.cancel();
    state = true;

    _timer = Timer.periodic(interval, (_) async {
      final isLocked = ref.read(appLockStateControllerProvider);
      if (isLocked) return;

      await refreshNow();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    state = false;
  }

  Future<void> refreshNow() async {
    ref.invalidate(networkInfoControllerProvider);
    ref.invalidate(assetsControllerProvider);
    ref.invalidate(txHistoryControllerProvider);
    ref.invalidate(rpcStatusControllerProvider);
  }
}
