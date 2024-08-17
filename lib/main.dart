import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:adasba_2024/constants/app_colors.dart';
import 'package:adasba_2024/presentation/providers/router_config.dart';

void main() async {
  setPathUrlStrategy();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerConfigProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es')],
      title: 'ADASBA',
      theme: ThemeData(
        dialogBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.azulPrincipal,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
