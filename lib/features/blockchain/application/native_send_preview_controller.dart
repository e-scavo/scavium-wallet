import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/core/utils/evm_format.dart';
import 'package:scavium_wallet/features/blockchain/data/scavium_rpc_service.dart';
import 'package:scavium_wallet/features/blockchain/domain/native_send_preview.dart';
import 'package:web3dart/web3dart.dart';

final nativeSendPreviewControllerProvider =
    AsyncNotifierProvider<NativeSendPreviewController, NativeSendPreview?>(
      NativeSendPreviewController.new,
    );

class NativeSendPreviewController extends AsyncNotifier<NativeSendPreview?> {
  @override
  Future<NativeSendPreview?> build() async {
    return null;
  }

  Future<void> buildPreview({
    required String toAddress,
    required String amountText,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final rpc = ref.read(scaviumRpcServiceProvider);

      final amountWei = EvmFormat.parseUnits(amountText, 18);
      if (amountWei <= BigInt.zero) {
        throw Exception('Monto inválido');
      }

      final gasPriceWei = await rpc.getCurrentGasPriceWei();
      final gasLimit = await rpc.estimateGasForNativeTransfer(
        to: EthereumAddress.fromHex(toAddress),
        value: EtherAmount.inWei(amountWei),
      );

      final feeWei = gasLimit * gasPriceWei;
      final totalWei = amountWei + feeWei;

      return NativeSendPreview(
        toAddress: toAddress,
        amountText: amountText,
        amountWei: amountWei,
        gasLimit: gasLimit,
        gasPriceWei: gasPriceWei,
        estimatedFeeWei: feeWei,
        totalCostWei: totalWei,
      );
    });
  }

  void clear() {
    state = const AsyncData(null);
  }
}
