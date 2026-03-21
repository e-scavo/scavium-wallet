class RpcUrlValidator {
  const RpcUrlValidator._();

  static void validateAll(List<String> rpcUrls) {
    if (rpcUrls.isEmpty) {
      throw ArgumentError('La lista de RPC URLs no puede estar vacía');
    }

    for (final rpcUrl in rpcUrls) {
      validate(rpcUrl);
    }
  }

  static void validate(String rpcUrl) {
    final uri = Uri.tryParse(rpcUrl);

    if (uri == null) {
      throw ArgumentError('RPC URL inválida: $rpcUrl');
    }

    if (!uri.hasScheme || !uri.hasAuthority) {
      throw ArgumentError('RPC URL incompleta: $rpcUrl');
    }

    if (uri.scheme.toLowerCase() != 'https') {
      throw ArgumentError(
        'RPC URL insegura. Se requiere HTTPS en esta fase: $rpcUrl',
      );
    }
  }
}
