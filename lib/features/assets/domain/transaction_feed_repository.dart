import 'package:scavium_wallet/features/assets/domain/transaction_feed_item.dart';

abstract class TransactionFeedRepository {
  Future<List<TransactionFeedItem>> getAddressTransactions({
    required String address,
  });
}
