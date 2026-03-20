class NativeSendPreview {
  final String toAddress;
  final String amountText;
  final BigInt amountWei;
  final BigInt gasLimit;
  final BigInt gasPriceWei;
  final BigInt estimatedFeeWei;
  final BigInt totalCostWei;

  const NativeSendPreview({
    required this.toAddress,
    required this.amountText,
    required this.amountWei,
    required this.gasLimit,
    required this.gasPriceWei,
    required this.estimatedFeeWei,
    required this.totalCostWei,
  });
}
