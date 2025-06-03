import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:med_sync/features/auth/data/repositories/auth_repository.dart';
import 'package:med_sync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:med_sync/features/auth/presentation/pages/sign_in_page.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_bloc.dart';
import 'package:med_sync/features/welcome/presentation/pages/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();

  FlutterNativeSplash.remove();
}

Future<bool> isFirstTime() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('is_first_time') ?? true;
  if (isFirstTime) {
    await prefs.setBool('is_first_time', false);
  }
  return isFirstTime;
}

void main() async {
  await initializeApp();
  final firstTime = await isFirstTime();
  runApp(MyApp(isFirstTime: firstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WelcomeBloc()),
        RepositoryProvider(create: (context) => AuthRepository()),
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: context.read<AuthRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Med Sync',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: isFirstTime ? const WelcomeScreen() : const SignInPage(),
      ),
    );
  }
}
