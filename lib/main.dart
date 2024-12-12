import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/app/modules/authentication/presentation/pages/login_page.dart';
import 'package:tezda_task/app/shared/functions/app_functions.dart';
import 'package:tezda_task/app/shared/helpers/classes/preferences/preferences.dart';
import 'package:tezda_task/core/framework/theme/colors/app_theme_provider.dart';
import 'package:tezda_task/firebase_options.dart';

import 'app/modules/products/presentation/pages/products_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initalize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.read(appThemeProvider).colors;
    final hasLoggedIn = getUser() != null;
    return MaterialApp(
      title: 'Tezda Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PlusJakartaDisplay',
        colorScheme: ColorScheme.fromSeed(seedColor: colors.primary),
      ),
      home: hasLoggedIn ? const ProductsPage() : const LoginPage(),
    );
  }
}
