import 'package:flutter/material.dart';
import 'config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void  main() async{

  //Para variables de entorno
  await Environment.initEnvironment();


  runApp(
    const ProviderScope(child: MyApp())
    );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Formulaciones',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}