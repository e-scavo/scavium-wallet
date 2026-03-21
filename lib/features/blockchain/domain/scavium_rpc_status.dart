class ScaviumRpcStatus {
  final int activeIndex;
  final String activeRpcUrl;
  final List<String> rpcUrls;
  final Map<String, DateTime?> cooldownUntilByRpcUrl;
  final DateTime? lastSwitchAt;
  final String? lastSwitchReason;
  final String? lastFailedRpcUrl;

  const ScaviumRpcStatus({
    required this.activeIndex,
    required this.activeRpcUrl,
    required this.rpcUrls,
    required this.cooldownUntilByRpcUrl,
    required this.lastSwitchAt,
    required this.lastSwitchReason,
    required this.lastFailedRpcUrl,
  });

  String get activeRpcName => 'RPC ${activeIndex + 1}';

  bool isCoolingDown(String rpcUrl) {
    final until = cooldownUntilByRpcUrl[rpcUrl];
    if (until == null) return false;
    return until.isAfter(DateTime.now());
  }

  Duration? cooldownRemaining(String rpcUrl) {
    final until = cooldownUntilByRpcUrl[rpcUrl];
    if (until == null) return null;

    final diff = until.difference(DateTime.now());
    if (diff.isNegative) {
      return Duration.zero;
    }

    return diff;
  }

  bool get hasRecentFailover {
    if (lastSwitchReason != 'failover') return false;
    if (lastSwitchAt == null) return false;
    return true;
  }
}
