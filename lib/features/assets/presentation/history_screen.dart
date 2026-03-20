import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scavium_wallet/core/config/app_config.dart';
import 'package:scavium_wallet/features/assets/application/tx_history_controller.dart';
import 'package:scavium_wallet/features/assets/domain/tx_status.dart';
import 'package:scavium_wallet/shared/widgets/feedback/state_message.dart';
import 'package:scavium_wallet/shared/widgets/scavium_card.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(txHistoryControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: [
          IconButton(
            onPressed:
                () =>
                    ref
                        .read(txHistoryControllerProvider.notifier)
                        .refreshStatuses(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      child: state.when(
        data: (items) {
          return RefreshIndicator(
            onRefresh:
                () =>
                    ref
                        .read(txHistoryControllerProvider.notifier)
                        .refreshStatuses(),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'This history currently shows locally tracked outgoing transactions and their receipt status. Incoming transactions require explorer/indexer integration.',
                ),
                const SizedBox(height: 16),
                if (items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: StateMessage(
                      icon: Icons.receipt_long,
                      title: 'No transactions yet',
                      subtitle: 'Your recent activity will appear here.',
                    ),
                  )
                else
                  ...items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ScaviumCard(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            item.status == TxStatus.confirmed
                                ? Icons.check_circle_outline
                                : item.status == TxStatus.failed
                                ? Icons.error_outline
                                : Icons.schedule,
                          ),
                          title: Text('${item.amountDisplay} ${item.symbol}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('To: ${item.toAddress}'),
                              Text('Hash: ${item.txHash}'),
                              Text(item.createdAt.toLocal().toString()),
                            ],
                          ),
                          trailing: Text(item.status.name),
                          onTap: () async {
                            final uri = Uri.parse(
                              '${AppConfig.current.txExplorerPath}/${item.txHash}',
                            );
                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          },
                        ),
                      ),
                    );
                  }),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (e, _) => StateMessage(
              icon: Icons.error_outline,
              title: 'Error loading history',
              subtitle: '$e',
            ),
      ),
    );
  }
}
