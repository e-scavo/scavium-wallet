import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/assets/application/assets_controller.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/assets/domain/tx_history_entry.dart';
import 'package:scavium_wallet/features/assets/domain/tx_kind.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/blockchain/domain/transaction_send_result.dart';
import 'package:web3dart/web3dart.dart';

final sendTransactionControllerProvider =
    AsyncNotifierProvider<SendTransactionController, TransactionSendResult?>(
      SendTransactionController.new,
    );

class SendTransactionController extends AsyncNotifier<TransactionSendResult?> {
  @override
  Future<TransactionSendResult?> build() async {
    return null;
  }

  Future<void> sendNative({
    required String toAddress,
    required String amountText,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final service = ref.read(scaviumRpcServiceProvider);

      try {
        final amountWei = EtherAmount.inWei(
          EtherAmount.fromUnitAndValue(
            EtherUnit.ether,
            amountText.replaceAll(',', '.'),
          ).getInWei,
        );

        final result = await service.sendNativeTransaction(
          toAddress: toAddress,
          amount: amountWei,
        );

        await ref
            .read(txHistoryControllerProvider.notifier)
            .addEntry(
              TxHistoryEntry(
                id: '${DateTime.now().microsecondsSinceEpoch}',
                kind: TxKind.nativeSend,
                status:
                    result.confirmed ? TxStatus.confirmed : TxStatus.pending,
                symbol: AppConfig.current.nativeSymbol,
                tokenAddress: null,
                toAddress: toAddress,
                amountDisplay: amountText,
                txHash: result.txHash,
                createdAt: DateTime.now(),
              ),
            );

        ref.invalidate(assetsControllerProvider);

        return result;
      } catch (e) {
        final normalized = await service.normalizeRpcError(e);
        throw Exception(normalized);
      }
    });
  }
}
