import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';

final rpcHealthControllerProvider =
    AsyncNotifierProvider<RpcHealthController, String>(RpcHealthController.new);

class RpcHealthController extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final service = ref.read(scaviumRpcServiceProvider);

    try {
      final info = await service.getNetworkInfo();
      return 'RPC OK | chainId=${info.chainId} | block=${info.latestBlock}';
    } catch (e) {
      return 'RPC ERROR | $e';
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(scaviumRpcServiceProvider);
      final info = await service.getNetworkInfo();
      return 'RPC OK | chainId=${info.chainId} | block=${info.latestBlock}';
    });
  }
}
