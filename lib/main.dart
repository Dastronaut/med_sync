import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:med_sync/core/router/app_router.dart';
import 'package:med_sync/features/auth/data/repositories/auth_repository.dart';
import 'package:med_sync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();

  FlutterNativeSplash.remove();
}

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFirstLaunch(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        final isFirstLaunch = snapshot.data!;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => WelcomeBloc()),
            RepositoryProvider(create: (context) => AuthRepository()),
            BlocProvider(
              create: (context) =>
                  AuthBloc(authRepository: context.read<AuthRepository>()),
            ),
          ],
          child: MaterialApp.router(
            title: 'Med Sync',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            routerConfig: AppRouter.router(isFirstLaunch),
          ),
        );
      },
    );
  }

  Future<bool> _isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('is_first_time') ?? true;
    if (isFirstTime) {
      await prefs.setBool('is_first_time', false);
    }
    return isFirstTime;
  }
}
