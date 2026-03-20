import 'package:scavium_wallet/features/assets/domain/tx_status.dart';

class TransactionFeedItem {
  final String txHash;
  final String from;
  final String to;
  final String symbol;
  final String amountDisplay;
  final DateTime? timestamp;
  final TxStatus status;
  final bool isIncoming;

  const TransactionFeedItem({
    required this.txHash,
    required this.from,
    required this.to,
    required this.symbol,
    required this.amountDisplay,
    required this.timestamp,
    required this.status,
    required this.isIncoming,
  });
}
