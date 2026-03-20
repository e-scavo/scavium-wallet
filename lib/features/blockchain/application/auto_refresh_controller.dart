import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/assets/application/assets_controller.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/blockchain/application/network_info_controller.dart';
import 'package:scavium_wallet/features/lock/application/app_lock_state_controller.dart';

final autoRefreshControllerProvider =
    NotifierProvider<AutoRefreshController, bool>(AutoRefreshController.new);

class AutoRefreshController extends Notifier<bool> {
  Timer? _timer;

  @override
  bool build() {
    ref.onDispose(() {
      _timer?.cancel();
    });

    return false;
  }

  void start({Duration interval = const Duration(seconds: 20)}) {
    _timer?.cancel();
    state = true;

    _timer = Timer.periodic(interval, (_) async {
      final isLocked = ref.read(appLockStateControllerProvider);
      if (isLocked) return;

      await _refreshAll();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    state = false;
  }

  Future<void> refreshNow() async {
    await _refreshAll();
  }

  Future<void> _refreshAll() async {
    try {
      await ref.read(networkInfoControllerProvider.notifier).refreshData();
    } catch (_) {}

    try {
      await ref.read(assetsControllerProvider.notifier).refreshAssets();
    } catch (_) {}

    try {
      await ref.read(txHistoryControllerProvider.notifier).refreshStatuses();
    } catch (_) {}
  }
}
