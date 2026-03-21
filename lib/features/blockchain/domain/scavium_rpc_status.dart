class ScaviumRpcStatus {
  final int activeIndex;
  final String activeRpcUrl;
  final List<String> rpcUrls;
  final Map<String, DateTime?> cooldownUntilByRpcUrl;

  const ScaviumRpcStatus({
    required this.activeIndex,
    required this.activeRpcUrl,
    required this.rpcUrls,
    required this.cooldownUntilByRpcUrl,
  });

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
}
