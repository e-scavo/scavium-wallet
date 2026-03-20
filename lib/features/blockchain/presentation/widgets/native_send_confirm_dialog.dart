import 'package:flutter/material.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/core/utils/evm_format.dart';
import 'package:scavium_wallet/features/blockchain/domain/native_send_preview.dart';

class NativeSendConfirmDialog extends StatelessWidget {
  final NativeSendPreview preview;
  final VoidCallback onConfirm;

  const NativeSendConfirmDialog({
    super.key,
    required this.preview,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final amount = EvmFormat.formatUnits(preview.amountWei, 18);
    final fee = EvmFormat.formatUnits(preview.estimatedFeeWei, 18);
    final total = EvmFormat.formatUnits(preview.totalCostWei, 18);

    return AlertDialog(
      title: const Text('Confirm transaction'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText('To: ${preview.toAddress}'),
          const SizedBox(height: 12),
          Text('Amount: $amount ${AppConfig.current.nativeSymbol}'),
          const SizedBox(height: 8),
          Text('Gas limit: ${preview.gasLimit}'),
          const SizedBox(height: 8),
          Text('Gas price: ${preview.gasPriceWei} wei'),
          const SizedBox(height: 8),
          Text('Estimated fee: $fee ${AppConfig.current.nativeSymbol}'),
          const SizedBox(height: 8),
          Text('Total: $total ${AppConfig.current.nativeSymbol}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
