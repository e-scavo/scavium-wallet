import 'package:scavium_wallet/core/config/app_flavor.dart';

class AppConfig {
  final AppFlavor flavor;
  final String appName;
  final List<String> rpcUrls;
  final String explorerBaseUrl;
  final int chainId;
  final String nativeSymbol;
  final int nativeDecimals;

  const AppConfig({
    required this.flavor,
    required this.appName,
    required this.rpcUrls,
    required this.explorerBaseUrl,
    required this.chainId,
    required this.nativeSymbol,
    required this.nativeDecimals,
  });

  /// Compatibilidad total con el código existente.
  /// Durante esta fase seguimos usando el primer endpoint como primario.
  String get rpcUrl {
    if (rpcUrls.isEmpty) {
      throw StateError('AppConfig.rpcUrls no puede estar vacío');
    }
    return rpcUrls.first;
  }

  String get addressExplorerPath => '$explorerBaseUrl/address';
  String get txExplorerPath => '$explorerBaseUrl/tx';

  static const current = AppConfig(
    flavor: AppFlavor.dev,
    appName: 'SCAVIUM Wallet',
    rpcUrls: [
      'https://r01.testnet.scavium.network',
      'https://r02.testnet.scavium.network',
    ],
    explorerBaseUrl: 'https://explorer.testnet.scavium.network',
    chainId: 1987374788,
    nativeSymbol: 'SCV',
    nativeDecimals: 18,
  );
}
