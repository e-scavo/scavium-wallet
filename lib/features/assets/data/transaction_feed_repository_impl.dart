import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/assets/domain/transaction_feed_item.dart';
import 'package:scavium_wallet/features/assets/domain/transaction_feed_repository.dart';

final transactionFeedRepositoryProvider = Provider<TransactionFeedRepository>((
  ref,
) {
  return TransactionFeedRepositoryImpl();
});

class TransactionFeedRepositoryImpl implements TransactionFeedRepository {
  @override
  Future<List<TransactionFeedItem>> getAddressTransactions({
    required String address,
  }) async {
    return [];
  }
}
