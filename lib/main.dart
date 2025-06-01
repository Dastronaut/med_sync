import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_sync/features/auth/data/repositories/auth_repository.dart';
import 'package:med_sync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_bloc.dart';
import 'package:med_sync/features/welcome/presentation/pages/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WelcomeBloc()),
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Med Sync',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
