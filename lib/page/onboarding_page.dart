import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_notes/page/note_list_page.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = '/';
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  Future<void> setCompleteIntro(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCompletedIntro', value);
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      showSkipButton: true,
      skip: const Text(
        'Skip',
      ),
      onSkip: () async {
        await setCompleteIntro(true);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const NoteListPage(),
          ),
        );
      },
      done: const Text(
        'Start',
      ),
      onDone: () async {
        await setCompleteIntro(true);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const NoteListPage(),
          ),
        );
      },
      next: const Text(
        'Next',
      ),
      dotsDecorator: DotsDecorator(
        activeSize: const Size(
          30,
          10,
        ),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: 'How to add',
          body: 'Touch the plus button!',
          image: Image.asset(
            'assets/add.png',
          ),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'How to color',
          body: 'Touch the palette button!',
          image: Image.asset('assets/color.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: 'How to save',
          body: 'Touch the save button!',
          image: Image.asset('assets/save.png'),
          decoration: getPageDecoration(),
        ),
      ],
    );
  }
}

PageDecoration getPageDecoration() {
  return const PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
    bodyTextStyle: TextStyle(
      fontSize: 18,
    ),
    imagePadding: EdgeInsets.only(
      top: 40,
    ),
  );
}
