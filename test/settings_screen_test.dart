import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scavium_wallet/core/app_identity/app_version_info.dart';
import 'package:scavium_wallet/core/app_identity/app_version_provider.dart';
import 'package:scavium_wallet/features/settings/presentation/settings_screen.dart';

void main() {
  testWidgets('renders organized settings sections and safe actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appVersionInfoProvider.overrideWith(
            (ref) async => const AppVersionInfo(
              appName: 'SCAVIUM Wallet',
              semanticVersion: '0.2.2',
              buildNumber: '1',
            ),
          ),
        ],
        child: const MaterialApp(home: SettingsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Security & recovery'), findsOneWidget);
    expect(find.text('Export encrypted backup'), findsOneWidget);
    expect(find.text('Signing'), findsOneWidget);
    expect(find.text('Sign message'), findsOneWidget);
    expect(find.text('Diagnostics'), findsOneWidget);
    expect(find.text('RPC diagnostics'), findsOneWidget);
    expect(find.text('Danger zone', skipOffstage: false), findsOneWidget);
    expect(find.text('Reset wallet', skipOffstage: false), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    expect(find.text('About'), findsOneWidget);
    expect(find.text('SCAVIUM Wallet'), findsOneWidget);
    expect(find.text('SCAVIUM Wallet 0.2.2 (1)'), findsOneWidget);
    expect(find.text('Version 0.4.0'), findsNothing);
  });
}
