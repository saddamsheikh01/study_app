import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

import '../../misc/resources.dart';
import 'onboarding.dart';
import 'onboarding_content.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static final _contents = [
    Onboarding(
      "Missed a note?",
      "Upload and download notes, save your brain",
      R.imageOnboarding1,
    ),
    Onboarding(
      "Broke from buying books?",
      "Buy, sell, and swap used books, save your wallet",
      R.imageOnboarding2,
    ),
    Onboarding(
      "Share your thoughts",
      "Leave reviews, help others make informed choices",
      R.imageOnboarding3,
    ),
    Onboarding(
      "You made it!",
      "Thou art ready to enter the StudySwap realm",
      R.imageOnboarding4,
    ),
  ];

  final ValueNotifier<double> _notifier = ValueNotifier(0);
  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    _pageController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _contents
                  .asMap()
                  .entries
                  .map((entry) => OnboardingContent(
                    onboarding: entry.value,
                    notifier: _notifier,
                    page: entry.key,
                  )
              )
                  .toList(growable: false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                      child: ValueListenableBuilder(valueListenable: _notifier, builder: (context, page, _) {
                        if (page.toInt() == _contents.length - 1) return const SizedBox.shrink();

                        return TextButton(onPressed: () {
                          _pageController.animateToPage(_contents.length - 1, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
                        }, child: Text("Skip"));
                      })
                  ) ,
                  Align(
                    alignment: Alignment.center,
                    child: SlidingIndicator(
                        notifier: _notifier,
                        activeIndicatorSize: 14.0,
                        inactiveIndicatorSize: 14.0,
                        margin: 4.0,
                        activeIndicator: Icon(
                          Icons.circle,
                          color: theme.colorScheme.secondary,
                        ),
                        inActiveIndicator: Icon(
                          Icons.circle_outlined,
                          color: theme.colorScheme.secondary,
                        ),
                        indicatorCount: _contents.length,
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: ValueListenableBuilder(valueListenable: _notifier, builder: (context, page, _) {
                        if (page.toInt() == _contents.length - 1) {
                          return FilledButton(onPressed: () {
                          _navigateToSignIn(context);
                        }, child: const Text("Start"));
                        }

                        return FilledButton(onPressed: () {
                          _pageController.animateToPage(page.toInt() + 1, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
                        }, child: Text("Next"));
                      })
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onScroll() {
    _notifier.value = _pageController.page ?? 0;
  }

  void _navigateToSignIn(BuildContext context) {
    Navigator.pushNamed(context, '/login');
  }
}
