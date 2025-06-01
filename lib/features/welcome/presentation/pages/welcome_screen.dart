import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:med_sync/features/auth/presentation/pages/sign_in_page.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_bloc.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_event.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_state.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: const WelcomeView(),
    );
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeBloc, WelcomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      context.read<WelcomeBloc>().add(UpdatePageIndex(value));
                    },
                    itemCount: state.welcomeData.length,
                    itemBuilder: (context, index) => WelcomeContent(
                      image: state.welcomeData[index]["image"],
                      text: state.welcomeData[index]['text'],
                      subtext: state.welcomeData[index]['subtext'],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          state.welcomeData.length,
                          (index) => buildDot(
                            index: index,
                            currentPage: state.currentPage,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFFFF7643),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                          child: const Text("Continue"),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AnimatedContainer buildDot({required int index, required int currentPage}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    super.key,
    required this.image,
    required this.text,
    required this.subtext,
  });

  final String? image;
  final String? text;
  final String? subtext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.network(image!, height: 300),
        const Spacer(),
        Text(text!, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),
        Text(
          subtext!,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(),
      ],
    );
  }
}
