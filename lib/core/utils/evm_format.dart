class EvmFormat {
  static String formatUnits(
    BigInt value,
    int decimals, {
    int maxFractionDigits = 6,
  }) {
    if (decimals == 0) return value.toString();

    final divisor = BigInt.from(10).pow(decimals);
    final whole = value ~/ divisor;
    final fraction = (value % divisor).toString().padLeft(decimals, '0');

    var trimmed = fraction;
    if (trimmed.length > maxFractionDigits) {
      trimmed = trimmed.substring(0, maxFractionDigits);
    }
    trimmed = trimmed.replaceFirst(RegExp(r'0+$'), '');

    if (trimmed.isEmpty) {
      return whole.toString();
    }

    return '$whole.$trimmed';
  }

  static BigInt parseUnits(String value, int decimals) {
    final normalized = value.trim().replaceAll(',', '.');
    if (normalized.isEmpty) return BigInt.zero;

    final parts = normalized.split('.');
    final whole = parts[0].isEmpty ? '0' : parts[0];
    final fraction = parts.length > 1 ? parts[1] : '';

    final paddedFraction =
        fraction.length > decimals
            ? fraction.substring(0, decimals)
            : fraction.padRight(decimals, '0');

    final combined = '$whole$paddedFraction'.replaceFirst(RegExp(r'^0+'), '');

    return BigInt.parse(combined.isEmpty ? '0' : combined);
  }
}
