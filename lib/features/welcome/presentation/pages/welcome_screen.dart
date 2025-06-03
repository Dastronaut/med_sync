import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_bloc.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_event.dart';
import 'package:med_sync/features/welcome/presentation/bloc/welcome_state.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeView();
  }
}

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleContinue(BuildContext context, WelcomeState state) {
    if (state.currentPage < state.welcomeData.length - 1) {
      _pageController.animateToPage(
        state.currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/sign-in');
    }
  }

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
                    controller: _pageController,
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
                            if (state.currentPage < state.welcomeData.length - 1) {
                              _pageController.animateToPage(
                                state.currentPage + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              context.go('/sign-in');
                            }
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
                          child: Text(
                            state.currentPage < state.welcomeData.length - 1
                                ? "Continue"
                                : "Get Started",
                          ),
                        ),
                      ),
                      const Spacer(),
                      // TextButton(
                      //   onPressed: () {
                      //     context.go('/sign-in');
                      //   },
                      //   child: const Text(
                      //     "Skip",
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       decoration: TextDecoration.underline,
                      //     ),
                      //   ),
                      // ),
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
