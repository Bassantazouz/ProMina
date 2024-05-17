import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_mina/core/utils/shered_utils.dart';
import 'package:pro_mina/view/home/home.dart';
import 'package:pro_mina/view/home/view_modal_home.dart';

import 'view/auth/login.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeViewModel>(
          create: (BuildContext context) => HomeViewModel(),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName:(_) => const HomeScreen()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
